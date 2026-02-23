Return-Path: <linux-pm+bounces-43034-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 99R3FfVNnGktDwQAu9opvQ
	(envelope-from <linux-pm+bounces-43034-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:54:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E391176775
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 039FA303DAC5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F01365A05;
	Mon, 23 Feb 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPoQAUdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C718C008;
	Mon, 23 Feb 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851248; cv=none; b=bR68pRGtCeKgT2pnuXmnWOHPH5LC7L87ckJ1Now+lAMC/uFWYqJIDyIadoxkwfc+TppUGGXUujPh3/SbyNDDEqt1W41vkMQBaFAZ8DMYvY8DtYMZDEuDzx7o4G8dKPF8Hvb/HrM6IFc7kSp6dJol/aSfTUWlCF8hY5UONV/4FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851248; c=relaxed/simple;
	bh=gLAwsoUfCx8iL0s8jP2+WxA04Yxo814hukZ3aYQ/5yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ4DaUjVThuOL3noLYsfOkWI0htOWMHKXlrpXmfuExz6NCLH//fuJPBWh2JVsfziNxLYo/c0yiFsgjrEXif2t8izUWMGNHNxNJBD0ZqVc9HlfPH23yObmfELPfjOrgnO8nX1hUQnHh+yYWkEs/2xiF49Y+jnvTc6hjaw0pjnu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPoQAUdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB435C116C6;
	Mon, 23 Feb 2026 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851248;
	bh=gLAwsoUfCx8iL0s8jP2+WxA04Yxo814hukZ3aYQ/5yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPoQAUdgE6SHEpmPkTyh4ibdwAfyK0zuzPDyAbV6PnvlE0rIHj8pAg+BmhLodjo4k
	 1s6GPEtatvIyM48M7y+XhXqs1hXWJWdwlgljotqme7VxyX3yTHCs2UO3+Gm9cTW8Bu
	 xqF3Akaoc2RdT5s4GZ1HI3rOCqz9/+iZn3WgTpVkW/WqMnX4nOdnIKX6Bmz/mXNYYC
	 6wpo5VzToyQq6nrOh+DogRCp5o5zUmP4H9B/eLYpjCxWM9cyziqszwUvDT6E1l70vj
	 ZH9KLRMdw7cKo7mNkA5jJJjBrhyX3QZbrZjX6P69QcPqlo8eXYvOdJyDEosOJY9jHZ
	 NDVU1mGzJK6+Q==
Date: Mon, 23 Feb 2026 18:23:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, sherry.sun@nxp.com, driver-core@lists.linux.dev
Subject: Re: [PATCH v7 2/3] gpio: Add fwnode_gpiod_get() helper
Message-ID: <tzk3sdv5o3ncsidpwu2vttrdbc753jryk7q5cxgju5q44dvfoi@6x6waofxlqic>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
 <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43034-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9E391176775
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 01:42:24PM +0530, Krishna Chaitanya Chundru wrote:
> Add fwnode_gpiod_get() as a convenience wrapper around
> fwnode_gpiod_get_index() for the common case where only the
> first GPIO is required.
> 
> This mirrors existing gpiod_get() and devm_gpiod_get() helpers
> and avoids open-coding index 0 at call sites.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  include/linux/gpio/consumer.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 0d8408582918680bfea6a04ccedfc0c75211907a..fee926c0262ce9dc4b9a3c151e74f2cf37470a49 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -596,6 +596,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
>  }
>  #endif /* CONFIG_GPIOLIB && CONFIG_HTE */
>  
> +static inline
> +struct gpio_desc *fwnode_gpiod_get(struct fwnode_handle *fwnode,
> +				   const char *con_id,
> +				   enum gpiod_flags flags,
> +				   const char *label)
> +{
> +	return fwnode_gpiod_get_index(fwnode, con_id, 0, flags, label);
> +}
> +
>  static inline
>  struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
>  					struct fwnode_handle *fwnode,
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

