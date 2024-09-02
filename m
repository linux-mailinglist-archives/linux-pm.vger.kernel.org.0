Return-Path: <linux-pm+bounces-13338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02359685CB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEA91C2228C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074617E900;
	Mon,  2 Sep 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnsTmaeB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1B13CF8E
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275420; cv=none; b=GOUsMV39zHIaogSfRlaS8RlzQ04+YqfvCDDiew/rT70SMPu73hbQL/z7+svIgOP2g2IXL1HYiprBvFQOrrT6lNg8AJWemsneYKcDNtIRRU4U9X1eJ8KGbrlHKDw1oi7LBI1CB70aTULbtLnGUQlKz/Dr6CsRJuVH8fXA2iznNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275420; c=relaxed/simple;
	bh=afGKlEcvIBL8y13KBacFrS2nAEcKGc9EG1pkvjKK2hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQm02q7WMwE1zBPU7A/i58EFefbsee4vaGgn8IX5yYkE3snfIG0C3uLFx4fhlC7cGVkvoGvT4uYZUTxGQ2vac6Vq8sokaY800oK8MZUiz+QLqSyAxk9ZzZ/GGiwx5g0J1zJmtgtC9wJ32CdMhx3Z57answw0wIlROvzM2p+/TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnsTmaeB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374bb08d011so1400288f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275415; x=1725880215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Yr1AbDz3pAF6i2Nwdc6oL92uHgHSwP5utweidTWwIA=;
        b=xnsTmaeBGuz72b9E56xtolEa4R/MeKC01+bJXWKmf8dywyFc8w6AbxVvYgCHfnsRuU
         e11IFiHPv4SJ/QVKvBbCYyKdLl0Vem+woQ+LnGDqCg/bNF+OSV3e3uXeAdR9LVtsyx6i
         AWhah6TtyL548eWw2QE6BZt65pPqYgeJ0iU9qwnfFfz7Uimht45TpAk9eYQegMGPFvkr
         PJzns3z9du9JPXBEJ5JdeNE6tP2dwtD4jsBIYx58EMXvP6/NnujpnOT9XIXyvFBapDwY
         VFu4pO+fBsUUSod0k5ZJ0Lld9NM9vqSGXzfJBZ8tT9yNZk1y0JLXZHe/q3WzvjGfccr3
         pViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275415; x=1725880215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yr1AbDz3pAF6i2Nwdc6oL92uHgHSwP5utweidTWwIA=;
        b=u4+qYZlziKSa214Vkkgf0GdEcTg1BFlrUqp6Akayf+eZfz1q4nummUmAH0rOOwlOG1
         fbfVFkNUz9pQedJLXMV/Nwyl0kWaDIL4o2sw7EKyqUV5o+LkKYpQnRHc0f9kDnFNwhh0
         nCddUI618i7rO057/Rua1763kV20ja2SvyG4TT8xetXbPZQn+wNr738uUMbzHzAZjg3F
         zJmXgWeL2iLTdXSFcunH2j91ThYYAItcQ+XxEHD/BzoxRUVTM3sthLP8h1hyZq6F967i
         a3BvREj50LhFb9y3Ppo6iR2lIIbuzLGaGWbpcVGV+ucdFT0EhIfeHwrLbDdXc+vVZxZG
         gpUw==
X-Forwarded-Encrypted: i=1; AJvYcCWtojZvxEWa5s3Q6ekjZp9WLUdojAwCTnp76L4188ciWZ4wmdTdsBMAoq8hQH6AG2s0R6e7nc4tlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCkttZZvTWfrVw4sYgoRxpLn8kDcZo5jZ4GnmI9KyONFDOq6p
	Y2a9LB4fG+QdYCtmDCbclSyzsHvd9/hGHiVhgroolk1m84h0tYYfhBZUK9guiZU=
X-Google-Smtp-Source: AGHT+IFFKOcLENrTzpSe+YOhxJHEo9JEH1LGbrPE9GTWkSgqUCf5imV2HQIPW388XVhZJlwUiOGE6g==
X-Received: by 2002:adf:ecc5:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-374c945c443mr2194700f8f.14.1725275414997;
        Mon, 02 Sep 2024 04:10:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6df1066sm133737835e9.18.2024.09.02.04.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:10:14 -0700 (PDT)
Message-ID: <b4fc2024-84cd-4b10-b974-9886421b536f@linaro.org>
Date: Mon, 2 Sep 2024 13:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: brcmstb_thermal: Simplify with
 dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>, mmayer@broadcom.com, rafael@kernel.org,
 florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240830103918.501234-1-yanzhen@vivo.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240830103918.501234-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 12:39, Yan Zhen wrote:
> dev_err_probe() is used to log an error message during the probe process
> of a device.
> 
> It can simplify the error path and unify a message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

