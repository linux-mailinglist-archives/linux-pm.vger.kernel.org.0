Return-Path: <linux-pm+bounces-43935-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNM6DYmWrmnRGQIAu9opvQ
	(envelope-from <linux-pm+bounces-43935-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:44:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B02366C8
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD37B30095D7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336637AA93;
	Mon,  9 Mar 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi6uSJTd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080E36BCE6;
	Mon,  9 Mar 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049412; cv=none; b=aA1wV4LqwSzbvYKCXQFkmRcpew2nMfmpI03EDZn9MWtaDxXGwrSyYNo5IIR8bQfOEPhmNax4HaQXsdq0q1DQFxJkcuior+62NkD7tECP/BtQ+24P3BaWS7csHAiRpLqoyxDpKTHYwp76m+RBeso+AS+zFbXxGMEIeNre5nepTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049412; c=relaxed/simple;
	bh=2lGo3t1RntZTSXyLwgxBc8rDVEWOtf0wRiWH5p0NqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCRv0KoJXOZPEiOVla+w+bnNWhbC9/FsXNB4yKaUNb+CKVxXUfFkhCmqY2Ce/1gvJUlrMgxAcjBdbn3S4FdFRBIoJeM1Y043EzWa0YQEIMVxuDura4S20dXjtVRskHmH3se9zADV77cswhxKNssOm8HWXEJMdvBcVktiX4Z9QFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi6uSJTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA2AC4CEF7;
	Mon,  9 Mar 2026 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773049412;
	bh=2lGo3t1RntZTSXyLwgxBc8rDVEWOtf0wRiWH5p0NqEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi6uSJTdeVJsjuruAOk6ckUNvZwU3AXUYiYYYsSIhq6opeYHnuE4gmuquMR0cztRC
	 nqRC6Nc4GX3YqCXsk4+LDu5O8cSqWyxa5w0fGkan6fcfvpN1m7+rozTfLyZQo7p1TK
	 kiB+oUtdGmqD2+jeRMBSCA7fAcdsTDGaLUPSvjbTJk0AT3ZMpGngJXhNICQJhEK78h
	 GfvXcXwopHYTxuIJWxDjnWeuZOjYGAlJ1C7Kix6np6FgK1kYHs5PKlDvQH/XKv6lXY
	 ypyFQ/amMNOemvj5SRkTKHLdIQf53sPwLCdI1PupnY/u/abcZ2olOEWqkzv00NtF06
	 brit18q6B1LkA==
Date: Mon, 9 Mar 2026 09:43:27 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@kernel.org>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v2 5/9] firmware: arm_scmi: Add SCMIv4.0 Powercap FCs
 support
Message-ID: <20260309-jade-salmon-of-education-7c901c@sudeepholla>
References: <20260204111950.3648160-1-philip.radford@arm.com>
 <20260204111950.3648160-6-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204111950.3648160-6-philip.radford@arm.com>
X-Rspamd-Queue-Id: 3A4B02366C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43935-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,broadcom.com,gmail.com,linaro.org,st.com,oss.nxp.com,amd.com,quicinc.com,ti.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:19:46AM +0000, Philip Radford wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> Add support for new SCMIv4.0 Powercap Fastchannels.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> [Philip: removed reference to old versioning logic]
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V1->V2
> - Removed creation of pi powercap_info struct due to legacy code
>   change
> ---
>  drivers/firmware/arm_scmi/powercap.c | 323 ++++++++++++++++++---------
>  1 file changed, 221 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index 3291bde78367..22bf8e480450 100644
> --- a/drivers/firmware/arm_scmi/powercap.c
> +++ b/drivers/firmware/arm_scmi/powercap.c
>  

[...]

> @@ -1019,37 +1092,77 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
>  };
>  
>  static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
> -					 u32 domain, struct scmi_fc_info **p_fc)
> +					 struct scmi_powercap_info *dom_info)
>  {
> -	struct scmi_fc_info *fc;
> -
> -	fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
> -	if (!fc)
> -		return;
> -
> -	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> -				   POWERCAP_CAP_SET, 4, domain, NULL,
> -				   &fc[POWERCAP_FC_CAP].set_addr,
> -				   &fc[POWERCAP_FC_CAP].set_db,
> -				   &fc[POWERCAP_FC_CAP].rate_limit);
> -
> -	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> -				   POWERCAP_CAP_GET, 4, domain, NULL,
> -				   &fc[POWERCAP_FC_CAP].get_addr, NULL,
> -				   &fc[POWERCAP_FC_CAP].rate_limit);
> -
> -	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> -				   POWERCAP_PAI_SET, 4, domain, NULL,
> -				   &fc[POWERCAP_FC_PAI].set_addr,
> -				   &fc[POWERCAP_FC_PAI].set_db,
> -				   &fc[POWERCAP_FC_PAI].rate_limit);
> -
> -	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> -				   POWERCAP_PAI_GET, 4, domain, NULL,
> -				   &fc[POWERCAP_FC_PAI].get_addr, NULL,
> -				   &fc[POWERCAP_FC_PAI].rate_limit);
> -
> -	*p_fc = fc;
> +	for (int id = 0; id < dom_info->num_cpli; id++) {
> +		struct scmi_fc_info *fc;
> +		u32 *cpl_id, zero_cpl_id = 0;
> +
> +		fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
> +		if (!fc)
> +			return;
> +
> +		/* NOTE THAT when num_cpli == 1 the arg *cpl_id is 0 */
> +		cpl_id = (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) ? &id : NULL;
> +
> +		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +					   POWERCAP_CAP_SET, 4, dom_info->id,
> +					   cpl_id,
> +					   &fc[POWERCAP_FC_CAP].set_addr,
> +					   &fc[POWERCAP_FC_CAP].set_db,
> +					   &fc[POWERCAP_FC_CAP].rate_limit);
> +
> +		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +					   POWERCAP_CAP_GET, 4, dom_info->id,
> +					   cpl_id,
> +					   &fc[POWERCAP_FC_CAP].get_addr, NULL,
> +					   &fc[POWERCAP_FC_CAP].rate_limit);
> +
> +		if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_PAI_SET, 4,
> +						   dom_info->id, NULL,
> +						   &fc[POWERCAP_FC_XAI].set_addr,
> +						   &fc[POWERCAP_FC_XAI].set_db,
> +						   &fc[POWERCAP_FC_XAI].rate_limit);
> +
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_PAI_GET, 4,
> +						   dom_info->id, NULL,
> +						   &fc[POWERCAP_FC_XAI].get_addr, NULL,
> +						   &fc[POWERCAP_FC_XAI].rate_limit);
> +		} else {
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_CAI_SET, 4,
> +						   dom_info->id, &id,
> +						   &fc[POWERCAP_FC_XAI].set_addr,
> +						   &fc[POWERCAP_FC_XAI].set_db,
> +						   &fc[POWERCAP_FC_XAI].rate_limit);
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_CAI_GET, 4,
> +						   dom_info->id, &id,
> +						   &fc[POWERCAP_FC_XAI].get_addr, NULL,
> +						   &fc[POWERCAP_FC_XAI].rate_limit);

Can the above "&id" changed to cpl_id like the first 2 instance for consistency
unless I am reading it wrong.

> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_MAI_SET, 4,
> +						   dom_info->id, &zero_cpl_id,
> +						   &fc[POWERCAP_FC_MAI].set_addr,
> +						   &fc[POWERCAP_FC_MAI].set_db,
> +						   &fc[POWERCAP_FC_MAI].rate_limit);
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_MAI_GET, 4,
> +						   dom_info->id, &zero_cpl_id,
> +						   &fc[POWERCAP_FC_MAI].get_addr, NULL,
> +						   &fc[POWERCAP_FC_MAI].rate_limit);
> +			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
> +						   POWERCAP_MEASUREMENTS_GET, 4,
> +						   dom_info->id, &zero_cpl_id,
> +						   &fc[POWERCAP_FC_MEASUREMENT].get_addr, NULL,
> +						   &fc[POWERCAP_FC_MEASUREMENT].rate_limit);

Also why should the above 3 as well as the NULL cpl_id calls be inside this
loop ?

-- 
Regards,
Sudeep

