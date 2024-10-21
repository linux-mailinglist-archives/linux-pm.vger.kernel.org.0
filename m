Return-Path: <linux-pm+bounces-16140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11839A901A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 21:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02F51C22966
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0391C9B82;
	Mon, 21 Oct 2024 19:48:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD021C3F0E
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540122; cv=none; b=mGFgeOBMHhz/ejwU1qCQr1ZRrcIMhM15j1tMlxh327VL6MduqhSDQU5BUF64PLxwhvIx3XGo/xcgzC63xjS84Qa+W3fHILn/Kt7X9hG+RaN0NsK9NQly+tO+S12aQL0aBU3XkoPqanNtkNxfHnjkJz4o/cL+o1Ow/MMYGEVxsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540122; c=relaxed/simple;
	bh=xhZgh8AgN7R1Cu519ijYUiresQM5YSvnhETiB0cChoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAN7jTeuUhDhoYR+L6gi8hU5Mw1934VnPxThQwdiT4siGXRWzfDIQUcCQUDo6/l3+4rfzF6SaJKUt05l3ucbDRuRS+Itgl8TYGBuc5Jk+NIKj0zzQX7cGlS5DYGi/eBH5Q7qB27yq96Vx/0ymQgT1mC7kavtBZIHaQT30Ly6SHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407B4497;
	Mon, 21 Oct 2024 12:49:09 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3DB83F528;
	Mon, 21 Oct 2024 12:48:38 -0700 (PDT)
Message-ID: <73d9ce78-c608-465f-9452-1f309a2e2437@arm.com>
Date: Mon, 21 Oct 2024 20:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] tools/lib/thermal: Make more generic the command
 encoding function
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-3-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241014094309.1430126-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 10:43, Daniel Lezcano wrote:
> The thermal netlink has been extended with more commands which require
> an encoding with more information. The generic encoding function puts
> the thermal zone id with the command name. It is the unique
> parameters.
> 
> The next changes will provide more parameters to the command. Set the
> scene for those new parameters by making the encoding function more
> generic.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   tools/lib/thermal/commands.c | 41 ++++++++++++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
> index 73d4d4e8d6ec..a9223df91dcf 100644
> --- a/tools/lib/thermal/commands.c
> +++ b/tools/lib/thermal/commands.c
> @@ -261,8 +261,23 @@ static struct genl_ops thermal_cmd_ops = {
>   	.o_ncmds	= ARRAY_SIZE(thermal_cmds),
>   };
>   
> -static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int cmd,
> -					 int flags, void *arg)
> +struct cmd_param {
> +	int tz_id;
> +};
> +
> +typedef int (*cmd_cb_t)(struct nl_msg *, struct cmd_param *);
> +
> +static int thermal_genl_tz_id_encode(struct nl_msg *msg, struct cmd_param *p)
> +{
> +	if (p->tz_id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cmd_cb,
> +					 struct cmd_param *param,
> +					 int cmd, int flags, void *arg)
>   {
>   	struct nl_msg *msg;
>   	void *hdr;
> @@ -276,7 +291,7 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int
>   	if (!hdr)
>   		return THERMAL_ERROR;
>   
> -	if (id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id))
> +	if (cmd_cb && cmd_cb(msg, param))
>   		return THERMAL_ERROR;

It's not in this code but also in older:
shouldn't we free the nlmsg_free(msg); before returns in this
function?


The rest design looks good

