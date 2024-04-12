Return-Path: <linux-pm+bounces-6299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5828A2692
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D592B1F2516F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 06:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1E383B5;
	Fri, 12 Apr 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zg3kGTnW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589C3611D
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903282; cv=none; b=nl1Hx26r56R71nomiqPyEF6uamYQiBD+r7/RBrRE58zWHu4LP4ANW61gYZc9mnAHz0OleJ2P8xEBbCuzrTapyemrJKGSNJz5+sct4/Z9p3H3o/Xg3vlvF7Zq6FHvKuA2a0U4OZdCpyft1cFVHdqEz09EpucYwu7CIijJ1UQPkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903282; c=relaxed/simple;
	bh=Xf3Qvz06ChTjt3NNxv8JB28kb5ddfgTfylD67tibqpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwDOrAO19voVIWV/18dXWiEvphp7YsUeQIpEglXDx0eJO5kRHl5E4smDrNm7+4OMXS+vStoUgfLitWphHh5TI/ShpgqUS1+gUWSjNjLAbNK74DjrQl9GaByb//MuLdZAAM6xdKiFfcmr63XiU31wQq1b+Kh2kjltAvvpWxnDJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zg3kGTnW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed01c63657so569841b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 23:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712903281; x=1713508081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apPZ6XNAlNDIylQ/q/6dilZ76kjUyGxWvmJrZFzfD4w=;
        b=zg3kGTnWfQB8h4rv5mVVSdxkiXhDrxN9A/fIb312t7+Li/9cNR2Om3yQaq+eivHujr
         3di8auKyN6Z2L1Jt575dQOAy1wesm/z09WWWI5Oc8pw3bzm9idICKGEiQSAHR/xoeXtM
         SeA7LSpJUnlW1le5k5I4kYpREzAlqXXIDYTvb5A3lpeXklW5brn2KR056feYSbhuEnhL
         kpsTmjinWAJAL8X1MQPhB13XBDnxw3GF0B2tdDjKV0KyBT24Ex3ug+zm7VwkkKIUDJdg
         aFGD4FxocpWTYxq7UGIXkvIi6WfRD4QN4P3kk3396uAbdOdzXoelMZJm5zorD1VvwOOs
         mDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903281; x=1713508081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apPZ6XNAlNDIylQ/q/6dilZ76kjUyGxWvmJrZFzfD4w=;
        b=c5fbVpYht0sz4PKN6d9J4fnhOBI/4wr7eGNM9hoTdHDu3d//hTBOPlDRabOD9S7rmO
         ON5YXPQ9hJxqfmGDD8UCUXCyTZiwnKyANtILZeFwMLPlkCwe3JJODslLyYPEI0VpCmuR
         bjq+miveVhP+CeN+KDcUfFEED6DyNHLV0RqVyNFzF4hcSxnFmpQ55yZYtLS9/vw0e/Mq
         DEDd736RQhs8twksyPVFv6vQrooAG4yU0cIsEZDFQrtt+0ZxOpu332AOPH9b/mm2ThYV
         od20z59Y0frjsG9m69TqzvPhI0px4t9H+7L16bJRuiVPDI3SLcnmvUOIf66NwQLZ8dkv
         DxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFBP4HwyrMR+7tbu0GbnXbhYLq9LF3ewPhnpaQ5NzWS0Q1jHkPdONWHVWtu+sMnVGxD6QMDw/Nl0cvhnSQCTrtBb7j036xRRE=
X-Gm-Message-State: AOJu0YzISNcwbREINrDOBxcg6Ugq1iPr84QDTpOHEVHH8qd8eOfJz+Ui
	6nPc5ZeKfB/UbOd4mC0VPye1T6MlEA1nPe0v1/t52IyQ4IRaGG1nJVVaQ3EC/P8=
X-Google-Smtp-Source: AGHT+IFVbE/Eyfm80YGhaFewYbdmD554u1rNm5djLK2fqSFsGiRb8Bs1bZ3FM+N5MfgT3jVw96aFCg==
X-Received: by 2002:a05:6a00:2387:b0:6ea:df6a:39e7 with SMTP id f7-20020a056a00238700b006eadf6a39e7mr2052486pfc.13.1712903280761;
        Thu, 11 Apr 2024 23:28:00 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id u12-20020a056a00124c00b006ed93e7ef22sm2173178pfi.39.2024.04.11.23.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:28:00 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:57:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: lizhe <sensor1010@163.com>
Cc: rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <20240412062758.yak3lpvuus7ba2e7@vireshk-i7>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <7bd5d6c1.32db8.18ed0f5e6c3.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd5d6c1.32db8.18ed0f5e6c3.Coremail.sensor1010@163.com>

On 12-04-24, 14:19, lizhe wrote:
> Why did you do that? Why did you plagiarize others' achievements? Is this the style of Linaro?

Even if your changes make sense, the discussions needs to be healthy. I am a
co-maintainer of the cpufreq subsystem and its mine and Rafael's responsibility
to keep things moving in the right direction.

This patch fixes a issue you never mentioned over LKML.

Lets not make this awkward, it won't help anyone.

Thanks.

-- 
viresh

