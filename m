Return-Path: <linux-pm+bounces-15435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C593B997EEA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D91C22EC5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAF1C3F11;
	Thu, 10 Oct 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZX5RYL9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C681C3F0D
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545001; cv=none; b=GxWAHrFp5P8e+9oLcwTVP7ZFwSoGdK9UTOdbOWVrtih4G08eUvE7o/q87l1gYNthfqlVwE7PBZXOjjxtJ5gKszs3K06q/XzB5HgoQS47ghfpI6S3eNXjwBvBLkhc94H44CcV1LRTEIoVDjzgu3sZKLoIk73LEDySHHmkhd4aP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545001; c=relaxed/simple;
	bh=S8BM5kLv/7qbIRBH2YHsWBUe3PgMv6WbjQqYtXXBAYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4lWEo54X2oJPrRIPvCKakCnUCPGvD+GzRN3iV2c5Jlxzm2qXo8reEoUYPAPrCdymB5jA2vTR27qIhGfybuc0z04kt3dJ1EGj+eM8dBozy5BXBKmjSctEWVPqQHc7bzte2KDnlSeAbsWkcaVXzP3ADNhYZ9ZavPU+J+z9I0H4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZX5RYL9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c77459558so5017785ad.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728544999; x=1729149799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+5Prl37y+oPOxtW/B94jgcZLfAINjWfeSjyFICOOrw=;
        b=GZX5RYL9DksYWkZnaI1w1kgGwVMCLzHgER9wSpn2CRnrdhSsQOHf4WAFQILqnyG+03
         qVgAB7bIe9YFbPGE2XmS3RpC2vF7RN0N4JkQo0p3lNOCZWZA79sSLFgxObGq2RFfNQUt
         grf43sWyNii3+PB1PJldJ0FLtL49nKIXVLjZTGIxxWtSXrkXtNSQwRjWA4uWKkUwFjP0
         Y/PhnyX/4LDea/v3aiQj/ibYXztv4i75aIl/8WFhJbnpBP+hBiHnmL5gfYhERaLpfNat
         O+o9BOXA41qeB2/EB9a/818Z/CDmIegGYzjYYyaezD1PcmMyqUcca3sn3vYt3ImetFmI
         osjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544999; x=1729149799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+5Prl37y+oPOxtW/B94jgcZLfAINjWfeSjyFICOOrw=;
        b=Q1FX6g4nzGqp6KyDO7HGmgrz8BtqM7Li9ANjCKnR66O6+7pK2i99crIByT+2j6ZEXY
         H/fJmkaHp3bz7OpgLT4iOFh4ISRVFVUqmRYuNMPblAxL1kEdmmx8Mmb5gQUtulvjnp4j
         aBTlUYEpB6rH76/xMfUQLXJuxIqir6i2W9CfZJ1XUYB1Q6l39nzgPAag8NxbgvdY/7el
         3L7HsltNN+KMnxLZ1Z9eS/YTORrgI5XnLuDIU0aOIgmR/rfPYLTDxSCSVsfaeiadYJQh
         kNwN8BssQompcSx5cCHEdfIS7q8c+Y76DKXyrMFIwrWOPHfNICnObXlSlyY4lJ4OprYN
         LI0A==
X-Forwarded-Encrypted: i=1; AJvYcCVrNrBuXU8+Ys3msmY3jocqx6gzhNpa4F5Gj4s0VfBY83+pxTkSGAmH/TOm+cH0CpFV1oxk0mP5Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JwE8MQi9AU3wiwu5qmMLEU1q/Wb0GyqlwN+nIiJ1uTuSCIYA
	9kaTwZ0AZAcCda4qY5w9uVphg4kI8PCJ5R5GgOluuFRR/UvvoqwSJZM98zoTrC48VMEHxAhamgJ
	Y
X-Google-Smtp-Source: AGHT+IHlSq5Z9PAO24zIaW9ZLvOAcQlxWCcK7dr0pBIbwWDMyARBkWlbkLgBOQTRvY3gm7azHJDyiw==
X-Received: by 2002:a17:902:d48a:b0:20b:770b:ad3b with SMTP id d9443c01a7336-20c7ea67808mr31061605ad.0.1728544999024;
        Thu, 10 Oct 2024 00:23:19 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1b9f3sm4463965ad.76.2024.10.10.00.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:23:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:53:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nishanth Menon <nm@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241010072316.y7irfuex6wa63an6@vireshk-i7>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
 <20241003171349.lphhvxy7lgwwdhay@marital>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003171349.lphhvxy7lgwwdhay@marital>

On 03-10-24, 12:13, Nishanth Menon wrote:
> The existing device tree works with this changes even without the
> dependency being merged. DT update can happen in the next window once
> the pieces are merged together.

Ahh, so I can just apply them directly. Thanks for clarifying that.

-- 
viresh

