Return-Path: <linux-pm+bounces-36826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F24C08C2E
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6C0734FFB5
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5102D77E3;
	Sat, 25 Oct 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTWlzsEm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0B2D592D
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373755; cv=none; b=YYg8/OKaNw+09G+x+XP9jOjQnFhq5qqc9C3aFajrCxRX1p/ECYiRqgyVDKgYJmcaZxqgvUe4xcK0smMrX2gVEon5hbRFm5RQ32yccv/2mAKjSWk0QA+3sucl4lTaWOLJJ+5JlijlUzmSWlCXJMs5KbhTh2uj6GIX8TcuveX4Nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373755; c=relaxed/simple;
	bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BH8bbOnoH+yrpDxFUG+1nOCLDv84Pr/3AqPQ0pV+Z4ZzCVSkuhqVFaQBRImnP5sPxwOtOt7RUjfGRrgZNIveXZ0VaG1l8CG866Hk3LxlU9VJ5cf2XiBJv15COEOMOPqW9jc7WXIjzh8R4ptxYqfkBqXtqSYc4Ej+VRPc5dPCuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTWlzsEm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7930132f59aso3716325b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761373753; x=1761978553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
        b=dTWlzsEm1l2G9adWWl3xBc7R3/a6QZRPzPRzfVNA3Az+VXjrOkqXkLctfH4bW1fo4w
         k9at0EvHSm9ekagkY79nm3/HK5/m5aTsHeR8zaj6PmiMF0Ve4Z3khG7o/dwOzPOyZJ6z
         9ZujqRNxRMXepJ11jGfIwMpcNDIeWYsKIVJYOGEQssG4uJZL51sxd4/OhdZhiruQc+d4
         Ve2HsMh6EO1WvBkr1H9YFRb/noihuCdlHGwxAZmUWkCo9dpUTZYAhxgXB5BzAtlRkS9U
         3GNSuNyIHFuyCKfemUKfh905RuFeNuVAHzZclkhYHWMG96DHdPp7STfc5KfL9VkemTwv
         THGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761373753; x=1761978553;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
        b=q7ATRkLtiguWapDxt0nTSC1Z8WqWipb675/vQ1NJm9zWc2IOwYXGGtoTrFfBPO1xsT
         0z/X51D/oznUYA3ZN3Y6+yI7KUw19kr2kIe9xJczkjk8HocQ8rNSao8zMlAY86YTF1nW
         oO3J9kkK5n0jOygN/PguPEgafSJG/yn10Z+WrB80MD00w8AgQTyEXS/hzFbJUTzhyAmF
         6SRXdtWy0MyZbyXIDaWnESXwko4nXmmhgnbC5J6WBDC+xDZ8YjGUZuI9dY1kMaHIEFf6
         HWD/2RQIyqzX6zS2ZkeptEmbaUzJosq1azcRN7yFjtknJsrMyrtQrlEySUWM2bvdPPJ0
         Xb1w==
X-Forwarded-Encrypted: i=1; AJvYcCVNNIxmN600TF+PBDhH2DqbX9sVcYu/3b7bANUsQik9xzGi7Vfv0UvZKHmT1tz2vGXDEvmXj+Wz4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRyrGJd5iJZBv6D/BZMy1HEZgtNAfgm9NIE8wMLkXJHKNSqnWb
	OuGmPocf2OpscNAS5qKUc9/BoPwQijNT6mIbVGMHLdXR5loowwGkRBEq
X-Gm-Gg: ASbGncth6NQ2CSQ3EQsKzJPI4fw9ciGZO92hUEhV6DixzxLDd4EwIJuCmPiXD2q3Zur
	FwTlLxxunveIgDvby46WC6BrmkJrZm2hD5Wjx1sjNiiiLHtb2eJPBU+1mA8QPv4yU6Qm0IALA+x
	J+6G6CMkOqCuEAXNAKgUAwhaZcpEqLF/vFq9TSHez7Zoq2rwyYQdjrNUmGXfnVVonSUR9gh+8d3
	tffWyYoKFZpd6IP4HHntKFLK8K6zvdmD6KC+1cXE2k9Zslu8pWENBrEtRvL/7jP/LS8I2iy3KJC
	htPQkcONFPuoBgyvWdjiG+qNwuKrrLuPg2r2T9VEkwjKk/qJfEZXLHwFQQ+d9T3vWmldoXssI1q
	fPz7FXIYOUSvEpkh6c8apir/mpT70fFSTfc0V/b7L+vt2mHof/Kop1V3PQ9lVgJSN6/74S4llwg
	llY9MyrpGCrZQlfp1nbNzMoAwJoFsWXeqfy9OfrCUlbOUgw45pL0sli73D
X-Google-Smtp-Source: AGHT+IFWUEUqUpK9BOM5WuZByjx+FKXT3VLhONWJFmh5THmG3nVw5cQe7vhxVbZm9c/e9p2ROCfQ7w==
X-Received: by 2002:a05:6a00:cd4:b0:7a2:7d0d:80d5 with SMTP id d2e1a72fcca58-7a28680406amr5047434b3a.16.1761373752751;
        Fri, 24 Oct 2025 23:29:12 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:443:a828:b6ba:688d? ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049f47sm1181005b3a.31.2025.10.24.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:29:12 -0700 (PDT)
Message-ID: <403df2fefa9b6f83f805de3da37c18c7d6ef661f.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: ally heev <allyheev@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet
	 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 11:59:05 +0530
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Based on the comments. I will drop this patch in next version

