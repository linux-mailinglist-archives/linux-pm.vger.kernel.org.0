Return-Path: <linux-pm+bounces-17740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41A9D20C2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1B280941
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863215535A;
	Tue, 19 Nov 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HedFkaSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48D1EA90
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001284; cv=none; b=nToFDlcKpfrQqFao/sjFJzYgG4fihhbPukq2Tg2/DlT8pqEn3p1ezxKeWVQ2pj7MEPJaUiNwz/DtON1DI0uW+RWsIJwNLyy5rkiWBMxTeAL8YBRucTQi/olGr+JMyUvzoo5IapXlZZrz260FCQ4noeGCvuGaVnW5+oRwkBf/pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001284; c=relaxed/simple;
	bh=e3OFRhPM41WMBWFocoxGAX9pQCoY+5qz29EryMfR188=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px44pWkq2uZCdeVQ5SbXxqEVkjBR2+NwU9GvqiIp/ZJi3pSsDnMmjRKc/3a3UlPV+M4kXMvLjYMDIvk6s8bplp71TrVJTR1EFUgVXKN4T6vUEIoEt5SnGB2EwK8i/UzfKPdT7/e1l99snGxN5KrYi7BnVktLdkELXPtsDn6svBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HedFkaSI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2242389a12.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 23:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732001282; x=1732606082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBeJh21HJZOCDVfM7Nr1yowrhAnMZKyjCkeStKypIic=;
        b=HedFkaSIOznIDrnDWkucAcxpzNALwA7jAwx7c7i6qrIASsjdiBKfX2BZvpR5uvmd7r
         n6PYw5HMU9s0NyFdalLIUuhq/+pAWDgfIbWD8O88QA5iWv5U1yfuIls/qS/n9YE/txFA
         3sF7icwe4yugrmRJrmgTjXB0lgZpVDiVHryJCwL0PJF/VDRuEcDH5sDqbV04+9fpIuHb
         CYSeybcxm12lK7YvQaZzCSAz16o77HEum75GLPf0SQ1jjKdWNAoCxRul/i1VOQ2Elk4U
         FoLajaTxqZ0LvolQYuuqw+sURISAvKESsoOhPB8lKlR2+tO3gutHtFrjKHjpZCt6LylB
         GkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732001282; x=1732606082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBeJh21HJZOCDVfM7Nr1yowrhAnMZKyjCkeStKypIic=;
        b=vYPLRx0yP1NmakT+Qg5UyitlH4Bf9FrKxKXDWIprR013QOtBdWynQ04g6wsduD5XHn
         0JO7Rk0KPFcF4jJxHlIeXo3D5Oz8kCuS5zIs9sU3tvQ1wRAj068HxuchOEDx83LGmNgE
         Ek57RBJ/7a88G1tq9JlsweQS/PBeba+JFtQOOhH/wDlxe6AxabNgXAKqFMV7cHWjNWXx
         fi5YazjiTdlgZ0rS/obUXeN2CcdUgPb0SJoTt2wiuaneGgUs+D13pJvlxOBPkOuWsr14
         8H3nKOUnOCrnOp//yQ0+9OD1oYxg53ptsoI6+OUVxOiohW5XpWq4X74R3wNV0uWFnZNV
         02Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVGywsqEsGoZSwjuOqIrutQ4M8Uf+/N11ydlwITMvy01YntwoUHyM0ISFMBhMChmZ0vsYxJ1fmrsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpAoTxPBoRgn20FP8EF95bU/y6v8xdxF061n5zmTtLvyEC84p
	lxU8DNpa5UC2ihJ+n/gQXmnlGHGkMmw9k0I2wwBnbpQAn5Qvp2wV/ZqgXLYu8CVa4gu0gXqBrjX
	r
X-Google-Smtp-Source: AGHT+IHJLqekCPLYaEe2knpfsDc5XMeTEXIH1fs/KtZQN/FHVFGvisg2UrHDymaT4m7kHPqSN5aAOA==
X-Received: by 2002:a05:6a20:9150:b0:1db:d8a5:7c82 with SMTP id adf61e73a8af0-1dc90b09f48mr21189048637.5.1732001282254;
        Mon, 18 Nov 2024 23:28:02 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dc7a3esm7125129a12.76.2024.11.18.23.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:28:01 -0800 (PST)
Date: Tue, 19 Nov 2024 12:57:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, pierre.gondois@arm.com,
	vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V8 1/1] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <20241119072759.oi75cdqrw4vl4fsc@vireshk-i7>
References: <20241114022916.644899-1-quic_sibis@quicinc.com>
 <20241114022916.644899-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114022916.644899-2-quic_sibis@quicinc.com>

On 14-11-24, 07:59, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> v8:
> * Drop patch 1 since it was picked up by Viresh
> * Leave policy->max update to the cpufreq_qos notifier [Vincent]
> * We sanitized the range_max from V3 since we dealt with
>   policy->max, now we can drop the check and policy member
>   from scmi_data.
> 
>  drivers/cpufreq/scmi-cpufreq.c | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Applied. Thanks.

-- 
viresh

