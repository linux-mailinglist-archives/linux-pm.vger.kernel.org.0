Return-Path: <linux-pm+bounces-41271-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANj4JMXScWk+MgAAu9opvQ
	(envelope-from <linux-pm+bounces-41271-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:33:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E380662871
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF9B5017F4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62638E5EC;
	Thu, 22 Jan 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYf6SCw8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6F48032D
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067054; cv=none; b=YUWinJUDu2TH5QeLyN1fUnKtezSFeyEcDGeRmnjteipKV+Vgy6hDdgzr7zdcGUuF0cVh6gSEtTJCUs+wNL+pnb85llcNKpkeQKw/eMF55oHrw/8m6PSmmLEcTfAtPrLX+YTXCezkHhrOo47b3X+UchmrtuVjG1U/c/VZ1NBv6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067054; c=relaxed/simple;
	bh=T5Ypnsa8MDyjO6Qva3bXjXTqLSMQHaoYz1VAssYf91E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqjgGX1dPm0zDAHrxS5FWZtxuHrCgeIyLaXfLYuDWbV7tETPV3AJb3u8r/u6RppvCTp47HLQhLqJVoGkQ474W3LcR3oouu5k4UuISvF3+pe69u3jM18seiaNE3MXnyvHGp850LngSG0G/IZ6M3/NLlduwZEkihQRWcif2CYeExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYf6SCw8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c633984fbeeso149657a12.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 23:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769067043; x=1769671843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrrxa96BIhGWswpl4TJ5U5hpH5KQregyz3Avx8gNFGU=;
        b=VYf6SCw8wZVjUwQCfVyiIm3JgGDG6VywiMgoQDQfIJmwJ6fPY3lanmsB4AosRcgRYN
         GlNNNhcsr5vnv1gFFPr0oinuSvDWXkXusZV2/s2zZL0v2/k3EOOehhZC/3je6IpFF7+T
         qsUY3pY2RtP85Ws/NO7ozno4p0pz9Fpao3QybupZBhbzK2iHR8qPt3aEnOlwlrVjIbvm
         SkiC34cdcBBGeB5iURiziQxJ3FMb2acbABt8jby+j7VFYEzEX9K12SkLiJA1wKRBs68i
         5+GPp2/S329gXbb2N2Yac+G1iJq8MIDdRvF2ZDAe6YVsD5OWhL7G8Ymdc9EAH5XbTUhQ
         i54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067043; x=1769671843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrrxa96BIhGWswpl4TJ5U5hpH5KQregyz3Avx8gNFGU=;
        b=vTodjgZ1Qrj1Cca5qch5xQUsugiw/Uf6DJ10PezX0PWUurZusC2nQ9c4G+ZQGO9um8
         c9LNVOEVZdJPwgC2fdzExu/N5voKdrZHcV5d8ifXMpBl1xBJp+K6o6ZIIBnHRtWnFelH
         8lYnDR/mKWd638vv51WBacYTepg/k4zQdeVEV0uDPP+0bd6rJNiF7gyPUeO+M9gYEHIh
         1u3STNdJYoFBLaHLYv1NPxiddARrhv+HAddBQvtN0+w0visHySThBnfd3jTL+SwWxHNc
         G2MjPhWal9tWser2cLg7JkrXKv0bYxbwomBT0Qntxy3hDZa0rx+Zhz5UFFuzh5sK3vHv
         2CVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmlgEUTI/pQO6ibCqHF5q+PSY8gZJIfNzfVj2mxF26FRO4GtCGKPSmaI0s6mbORGLhE3gjhq7cCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfQnR2RDcdfTAvth6MTP1HdE5386S02KQTAAT2nM/0gqVslN9
	I2GRKXpkLlacr6GN2gBiNiZseDaApmbQ2DiHW5xcrrC05r038o0UA2qW1rlXJple8xA=
X-Gm-Gg: AZuq6aI2X1JkrqwtYekcH5K/efH1Ogray7/GXlt+35hseqa24u7doHqwUo/gILymx1N
	+xduTG661PnNZS/EHac60TtDfr4qsScLd2RdIROBEG+8/tLi6AYEMJ2GuDbFlqgfh7WtP6g4UpI
	6Ep+6NZHyXogpDNMz3Kt87Phu63gwDpypDV7jWWeDjaBdwvcCXc7PywK04uzzxlF1vVBJVV2dlv
	SkZS8t6QPiWPcJ8L9EYhQBRz6BZF3e9HncV0pWq6cGkm+6D6pFZT0lg1TYANOkMDnkW1OELBTg3
	g8LVCC4wqOKLIDqVECenGbHX1MQbFJKXcCyNHKndyyhEkCQQdAzOVuKkpHnMRS2kknusNiB4aJc
	2g+61WRNK9vScit+TMP7m0Ktf3xbsxUUHxB7/ICBG11VGuavP3txN11BVnr77LS/8kfpilcnINJ
	VyA9Tr97hDrLs=
X-Received: by 2002:a17:902:fc85:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a7d2f9861fmr18379145ad.22.1769067042469;
        Wed, 21 Jan 2026 23:30:42 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a76c5f4fb0sm68311145ad.45.2026.01.21.23.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:30:41 -0800 (PST)
Date: Thu, 22 Jan 2026 13:00:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rafael@kernel.org, xiaopeitux@foxmail.com
Cc: konrad.dybcio@oss.qualcomm.com, ilia.lin@kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq: qcom-nvmem: add sentinel to
 qcom_cpufreq_ipq806x_match_list
Message-ID: <6kykizeqega4wsps25katcdhsavr2ktbbcn3clbgkdqgip2k4u@azxr5ryitlkv>
References: <tencent_E072C90BFC84600EC8B529829AFB81CA0105@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E072C90BFC84600EC8B529829AFB81CA0105@qq.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41271-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,foxmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,foxmail.com:email]
X-Rspamd-Queue-Id: E380662871
X-Rspamd-Action: no action

On 22-01-26, 09:44, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> The of_device_id table is expected to be NULL-terminated. Without the
> sentinel, the traversal of the array can lead to out-of-bound access,
> causing undefined behavior.
> 
> This adds the missing sentinel to the qcom_cpufreq_ipq806x_match_list
> array.
> 
> Fixes: 58f5d39d5ed8 ("cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> changlog in v2:
> Remove the extra commas
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 81e16b5a0245..b8081acba928 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -263,6 +263,7 @@ static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] __maybe_unuse
>  	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
>  	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
>  	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
> +	{ /* sentinel */ }
>  };
>  
>  static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael, can you take this directly for rc7 ?

-- 
viresh

