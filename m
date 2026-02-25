Return-Path: <linux-pm+bounces-43213-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gENHNmEDn2mZYgQAu9opvQ
	(envelope-from <linux-pm+bounces-43213-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 15:12:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0751988C7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F673019048
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93833D3331;
	Wed, 25 Feb 2026 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p6UN2QO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E73B8D53
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028700; cv=none; b=WrauDSXHhOLylfoZrb2LvdafEoEAbSp2gasTMmnqzTlpeuwAx2LJNhmm1LBTMTZgJsbZmdIH1pNqgsMu9s3UjL5bAa1rJeo4bhpEWttgdY7WAuPEZ3krY6nXPb0QPCpcfq+Krf+Z5FgvHfGPxJLWAyA78RUsyDZmFPfQRPvegdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028700; c=relaxed/simple;
	bh=tURLv0sm2ObtC/tNcvUtsxDprE5w9kvuVr1OZk1wISE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwM4Fr/QGPtIYX7pwQRQbizsngymYnMEeMNFZJYyDNHpS+xhNfdvqJcc6Xo3i3ai809Qb/9TV4IabgMBxIHfl/Ab50dm7I1Zn2O1hRtKoQhiLu25T7IkeXjkhSA8LZ1v9DO9HqXJ4G/OqAwdVlssuu3F+jX8SBAZrfFFV2Vo0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=p6UN2QO9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=od3up8LA4QWuWHDBqv+P6oVpa8CKp0bnaTd8fhvCKZs=; b=p6UN2QO95OKKBQnoln6IyVQC41
	KeUkZGynHy6LSadI71VbPa0STO2LDPAvFMZdF1MWyq39wq8EpSpuaaO0dE/SvnDekleU/iRvJAGmK
	hD8rj7c5F1Jxwuw+y8fyal1zvmws7WuPz+Xo5KPLIkXoE7OSI5FhCMAx3Ubsz60eaBprODLuAQTId
	Gwb47gZgaKdeGuOUAXYuosXZIteseb8IM4DcmvMGPFZ1IK2ecnO+GNUB6809FORqV8o8A5jY3WQAS
	zDAopCscV+NeybnqOnBFN/AivHw8yQDwZ4dMvknoxVQ87S10n4Qzu/K9vCZqv/Ciq6gwpXGaVXPtW
	uyp+PTzg==;
Received: from [189.7.87.203] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vvFby-005G79-Qu; Wed, 25 Feb 2026 15:11:35 +0100
Message-ID: <8cbde2e6-e5e3-4bfa-a7da-7ffe47b77658@igalia.com>
Date: Wed, 25 Feb 2026 11:11:29 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status
 read
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260212150039.67117-2-mcanal@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260212150039.67117-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43213-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linaro.org,broadcom.com,gmx.net];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 5B0751988C7
X-Rspamd-Action: no action

Hi Ulf,

Friendly ping on this patch. Could you take a look at it when you get a
chance? Florian and Stefan already reviewed it a couple of weeks ago and
it would be great to have it picked.

Best regards,
- Maíra

On 12/02/26 11:49, Maíra Canal wrote:
> bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
> call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
> expression:
> 
>      PM_READ(PM_GRAFX & PM_V3DRSTN)
> 
> computes the bitwise AND of the register offset PM_GRAFX with the
> bitmask PM_V3DRSTN before using the result as a register offset, reading
> from the wrong MMIO address instead of the intended PM_GRAFX register.
> The same issue affects the PM_IMAGE cases.
> 
> Fix by moving the closing parenthesis so PM_READ() receives only the
> register offset, and the bitmask is applied to the value returned by
> the read.
> 
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
> 
> Hi,
> 
> Most likely this bug went unnoticed as there is no in-tree driver
> currently calling reset_control_status() on the BCM2835 reset
> controller. Although I'm sending a fix to the .status callback, another
> possibility would be removing the implementation of this callback
> considering that (1) it's broken and (2) it's not used.
> 
> I'd appreciate your feedback about the most suitable option.
> 
> Best regards,
> - Maíra
> 
> ---
> 
>   drivers/pmdomain/bcm/bcm2835-power.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index 1d29addfe036..0450202bbee2 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -580,11 +580,11 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
>   
>   	switch (id) {
>   	case BCM2835_RESET_V3D:
> -		return !PM_READ(PM_GRAFX & PM_V3DRSTN);
> +		return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
>   	case BCM2835_RESET_H264:
> -		return !PM_READ(PM_IMAGE & PM_H264RSTN);
> +		return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
>   	case BCM2835_RESET_ISP:
> -		return !PM_READ(PM_IMAGE & PM_ISPRSTN);
> +		return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
>   	default:
>   		return -EINVAL;
>   	}


