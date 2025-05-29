Return-Path: <linux-pm+bounces-27790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183EAC778A
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 07:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC1F3AF40F
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE17253340;
	Thu, 29 May 2025 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGkLYK9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074F2505AA
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495813; cv=none; b=k/7EpawqxWPlhIal6+cZGWEKDRz3gw4QN3PHxn6oOKHmMK3tK49bOj1gDRVVc4gp8URs8x2WCvjQAtap288X4W4TZaaDFQZwMPkOe+N6bQPNLCMweNu04KP5ZHURBsU4+rJPg/z4Nrxr4nia1rfBc7YAVnyRLOtMe3zCYl01HUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495813; c=relaxed/simple;
	bh=TV45GHhtGOnRyTBAfSGdXdDInmU9h/yXgKV5kru+fSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IefP8J/Z2KhO2qbHg8YwJq2YRcujOD6j7tj/8KhL2S/SeD+bD3v/KBZsEnFb/aewgZiPKIahdZXW6MYXwlu8xXOCkS/Ggg60fcB8IqRGoY8xqqa5GMEx+y/mAL8p8PcNcAdwQjG6ATmqgyixdjkxDRCWsChPrB4U38ScFp8668s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGkLYK9Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e331215dbso11597635ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748495811; x=1749100611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwAROE/Iu0xe9jaIyFDWRqVVq6KxWwVTJxazuJbd0tw=;
        b=kGkLYK9YcyVhhCcMk9T7wenLoNAyQ+V9+ehAoh4jfgX7jfAvXKlRFZrVuNoFutKVRk
         z44IrO1CA7jWMMYbd/3zgQ8IpAUioE9QFWVay8/v3IIq9YV4414mg+1+JfNsDiQ5H9Qi
         ExKdVVMxquBayhlGB5clxCX0BfrYORkme2HCSQukPyXzwK5Y7QleycliDAuulG57M0Qk
         aRr7Yhu4iix3Z16yFOMX7HRwt6D3oyyCJpLfVC/xt/n25NDxSv9QwTiru+8PePj4dZn1
         emxLm5Ox2l3kSfP3GWC/x8XSW9UOYDX/XCdY591AHiZDKilzwnuBlEj032qMXGq/C2w9
         uaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748495811; x=1749100611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwAROE/Iu0xe9jaIyFDWRqVVq6KxWwVTJxazuJbd0tw=;
        b=c0ZSFUlJaG5iCTw4PcD7xR5ZQb1X1z1lbsMotGklzvzrekb0O2eWfYZ6zePjCLyDQ+
         Q3yc2gYvfAqgvMW/ybi5WeedciXBvfZKDn4qzmGgTWxmhHxdkTPtbTRxD3hFPLNVEAMK
         7XDKV20naRUqBG5ZBcf6wFwSnCS9HqiKP1iRqUHAqTrcJ9k9vh2RHwu1SZBDaqW62Ti3
         OrmFHimqS9O/IBb+G2vPZuwpyQeBq/uM39xVKckyYCQjmdpIQeply8FQHVAO9DWy/kRP
         Y/rwrluZpmilyiAS/+Z2z038pAmp1yUHxKKQePnDSvSmHHQJl5moHA6mUAEDrmVmKL58
         qDKg==
X-Forwarded-Encrypted: i=1; AJvYcCU5UeH39l7n8DnzM0Hw4hqxnfOOQFTTouF5ONPLVLck5M0J5oZIBawsy/td66JazA56VeSoQBRLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGGvI8yteAaq0lPYqFBvLhC6X60uyT7q1O1Yhc1Nwcc/viuU+
	1plalm62/owZ3W9wzpeF9kjVrbcoNXEbcBoXQejUgJD+HMvTspxKPbmh8meFUgpybmk=
X-Gm-Gg: ASbGnctFYp5IlsZ0eR1nKPOoE7apWGdFwrz10/3dUjBP8GvP0UEHt9U6qMqZ87aec2Z
	TuWc2s0DDTguFk7T06jx/bfh/4AC7CaPTKQirgDWtQrmlannOoMI22YfwUWCiJOb2FGuvPkQElw
	qVqgKga2HIe/Gs5Gq6cWWGzDHvZXncZhfCwqaaX7JAw8/lP2uwdcyHShREZEqzdHcpajjPxKeOA
	H1jZFfFXDDiJDZHunCwZmn0q+1RlOAmSmM2s++YdwYmLPbM2fq7REod2e497oqK7d5BiZKHBWK6
	VZD9nCJ/rtGEn9I/14A7gKQCmwL3Leh2VfOLvMuaMhAgWR2s8IiU
X-Google-Smtp-Source: AGHT+IFCUOB6AzVLuihAxx+qpBUabNryOsY6YuDFDgZ+ERpJUDUNP/BhRLmVicYoSS77fIKt7beIXQ==
X-Received: by 2002:a17:902:f546:b0:234:a05f:46df with SMTP id d9443c01a7336-234f67a7a6emr28192605ad.7.1748495811169;
        Wed, 28 May 2025 22:16:51 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd362fsm4570345ad.116.2025.05.28.22.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 22:16:50 -0700 (PDT)
Date: Thu, 29 May 2025 10:46:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Message-ID: <20250529051648.axvnwxvqf5zgroy5@vireshk-i7>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
 <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7>
 <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
 <CALHNRZ_NtdiOek_bEABYpkW+p=c2RgCC4o9EXmqmAkdv3o9i6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHNRZ_NtdiOek_bEABYpkW+p=c2RgCC4o9EXmqmAkdv3o9i6A@mail.gmail.com>

On 28-05-25, 12:29, Aaron Kling wrote:
> Is there any consensus on the best way to handle this? I'd like to
> keep the series moving.

I was waiting for Jon to provide further feedback here.

-- 
viresh

