Return-Path: <linux-pm+bounces-27618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF9AC2B5A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9811C02F38
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C620C006;
	Fri, 23 May 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b="h15mx+PW"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77661F3B87
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035803; cv=none; b=OwgBQTa+rSMz+xSijxHB5v0ZkcEQdmwBvr+NwVC35tD6g3rrCbD1tJLuWDM74CtmDnEJCDjvxTyBtL+ae956PdaLazmX8ncB6zuC8F8Tkjs2C16l4CgnhyDB+15BQei5mdwNNJPXbz6t+X/KSEZIyZNLLB+sj6ddit6HROek4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035803; c=relaxed/simple;
	bh=lJ5zSiF4j5yND5YdgyhzUPswF8T6nSe0Wmp93OX0+8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teZ/SW5IQXPPe4CNEEJwpVL5QmIKVvjhpqEgPiwoR3eHxmFLyNcLW0EXYp2eak86Hmk3lt/EboUXEnzlr1wpUmerbyQaUrZxiMUnzLodRWtSUaBI+KAUWIfKxl+zBdY7G6hKruHaX/PQsOvrayhfsyb0JLYrrNkcsWJr27G6R5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com; spf=pass smtp.mailfrom=kuruczgy.com; dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b=h15mx+PW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuruczgy.com
Message-ID: <db0e40b6-22f3-46aa-b35d-7a8729370ddf@kuruczgy.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuruczgy.com;
	s=default; t=1748035788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PqGEGzZ/UWkkbwLFFz4q788oyBfBlkNqJFmpYxsCts=;
	b=h15mx+PW2loABxmZdtwGKR+muslpE1BVAm8saqAqGA6Z1A9B3fcHmagAGsgW3ia3MmiDNW
	gycCXK08S3kipGXZ1mSMi7lzWcUSyfihn7JxC0VcT3CpFNvo5I+OxWLcKv0Nu+pTCjAU9P
	sK+l7Y3V4o3qIXhY0rnGwrcgMcajA9c=
Date: Fri, 23 May 2025 23:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] power: supply: qcom-battmgr: Add charge control
 support
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kernel@oss.qualcomm.com
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
 <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>
In-Reply-To: <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

> +static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
> +					   u32 target_soc, u32 delta_soc)
> +{
> +	struct qcom_battmgr_charge_ctrl_request request = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
> +		.enable = cpu_to_le32(1),
> +		.target_soc = cpu_to_le32(target_soc),
> +		.delta_soc = cpu_to_le32(delta_soc),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr, int soc)
> +{
> +	u32 target_soc, delta_soc;
> +	int ret;
> +
> +	if (soc < CHARGE_CTRL_START_THR_MIN ||
> +			soc > CHARGE_CTRL_START_THR_MAX) {
> +		dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
> +				CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * If the new start threshold is larger than the old end threshold,
> +	 * move the end threshold one step (DELTA_SOC) after the new start
> +	 * threshold.
> +	 */
> +	if (soc > battmgr->info.charge_ctrl_end) {
> +		target_soc = soc + CHARGE_CTRL_DELTA_SOC;
> +		target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
> +		delta_soc = target_soc - soc;
> +		delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
> +	} else {
> +		target_soc =  battmgr->info.charge_ctrl_end;
> +		delta_soc = battmgr->info.charge_ctrl_end - soc;
> +	}
> +
> +	mutex_lock(&battmgr->lock);
> +	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
> +	mutex_unlock(&battmgr->lock);
> +	if (!ret) {
> +		battmgr->info.charge_ctrl_start = soc;
> +		battmgr->info.charge_ctrl_end = target_soc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int soc)
> +{
> +	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
> +	int ret;
> +
> +	if (soc < CHARGE_CTRL_END_THR_MIN ||
> +			soc > CHARGE_CTRL_END_THR_MAX) {
> +		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
> +				CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (battmgr->info.charge_ctrl_start && soc > battmgr->info.charge_ctrl_start)
> +		delta_soc = soc - battmgr->info.charge_ctrl_start;
> +
> +	mutex_lock(&battmgr->lock);
> +	ret = qcom_battmgr_set_charge_control(battmgr, soc, delta_soc);
> +	mutex_unlock(&battmgr->lock);
> +	if (!ret) {
> +		battmgr->info.charge_ctrl_start = soc - delta_soc;
> +		battmgr->info.charge_ctrl_end = soc;
> +	}
> +
> +	return 0;
> +}

These function names sound quite generic, but AFAIU this patch is only 
adding charge control support for the SM8550. Is sc8280xp and x1e80100 
also expected to be supported using the same 
qcom_battmgr_charge_ctrl_request format?

Thanks,
György

