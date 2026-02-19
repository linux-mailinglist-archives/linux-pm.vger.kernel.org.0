Return-Path: <linux-pm+bounces-42875-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MHiJi9Ml2m2wQIAu9opvQ
	(envelope-from <linux-pm+bounces-42875-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:45:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF51615E5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C155D302EE84
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84834FF45;
	Thu, 19 Feb 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca8528Z1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8C34D4C2
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523115; cv=none; b=EO4KG99bXP26IBxEPMgsfAlc4Vm22vL5C1naacoZI/F5wVnhynf1Zd3HAOT04BJPYDwqS3/Jm8bQOWrK8dKZLcUqDKbBuhR0wIMR0gCEWgdBmIfxSpoIMq060nCkJtDJagW7jL9LXPMfLmKvvlsoOJNMoX1MufxxKH8Vs3RBtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523115; c=relaxed/simple;
	bh=t4deFB51LnQ53AFsy/xfWYZchzKH3oME5ZiZ+RzQWLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI5Pd6sU7IQsz92xrrAkvCZfOTpSeBbN/2Xw0KrkRLKqWPLGwm13/3c67wSNK1oY/PF3otS1/eAK44h1V3kpVa+w9Ox33Ax5elVthHl+HBF5jSJhwCPs5UfQZ9iq6MqkcbKk/jGhJy+g9noNbl9EO4zQWX3VqWjq+8syQWhxNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca8528Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C3BC2BCAF
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771523115;
	bh=t4deFB51LnQ53AFsy/xfWYZchzKH3oME5ZiZ+RzQWLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ca8528Z13MtQYDwZIV/4PfyeZOv8JCxcPOXsBX4EMgFE2O08uQgygE9NVFEJ01KWf
	 3pCwDXABMG3JwlnzNmqFgkfRcrDMqXb+1XuDwH+hHz+G0ZGVu+kUQIGL9tI4ImtaMj
	 GnmC+NxyuQoAiIt6p+yY9bJKAOXBoQsI6cxCD1zdeer1qc2uZKSp/RGWjRqPbhkgxk
	 km/WGIcLznMmjstm+igtOGMAi5dYR9ztjRfb7DgvF8NnnvkfRBD5KYdNrCs+CNiSt6
	 wiq7KIgn/14xOg5Vicy4IbhWmoR+abFy61opPDVJGQ/m72A8n8g9wDsVKdCQp2MYZN
	 TpvlVobv+rvQQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79495b1aaa7so10835977b3.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:45:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFZU1Nhq5tI+hutZOinXIq22VUt20TFz+qsiBpdy0y6qZWQy1SoMyxvJdjSIxK7nzEwjd+Mq47UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ2gGJLxXXH0Db/14BmPu5cJOZizfqTYD0B9VK3U58OjC0ft5
	ld7pRyLTmfRRBPFhJfyiHHcYDiMJh1n9k0UyZfnctEHEYOhyS5h+8Mt/ukke/xqBgD0WZJJ7JaQ
	CfQFYBqWXIx++9XumK4A/E+Fw2krCX/k=
X-Received: by 2002:a05:690c:b:b0:794:ff4d:9201 with SMTP id
 00721157ae682-7979e899694mr199251967b3.35.1771523114969; Thu, 19 Feb 2026
 09:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com> <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 18:45:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLmP_H4tegm2TkVy0TCDELomxORyEgHY41csBBXEWe5H=g@mail.gmail.com>
X-Gm-Features: AaiRm53hLGf1TLPgfB2vDs0s89u28dwO0xov-JW_O2PRLaGFVNVTVn4ICQasA1g
Message-ID: <CAD++jLmP_H4tegm2TkVy0TCDELomxORyEgHY41csBBXEWe5H=g@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] gpio: Add fwnode_gpiod_get() helper
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com, 
	driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42875-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3FDF51615E5
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 9:12=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:

> Add fwnode_gpiod_get() as a convenience wrapper around
> fwnode_gpiod_get_index() for the common case where only the
> first GPIO is required.
>
> This mirrors existing gpiod_get() and devm_gpiod_get() helpers
> and avoids open-coding index 0 at call sites.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Looks helpful.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

