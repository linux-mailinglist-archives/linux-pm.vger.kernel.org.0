Return-Path: <linux-pm+bounces-25084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA9A83A29
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453CA3AEF62
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41059204C38;
	Thu, 10 Apr 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTd5IMyz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2D1DFDE
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268533; cv=none; b=OFapykUlG7nY4Sj0w03O6hiQYfdatBe4NIsEaHOgT31I+tU2P3sElooS7v0FDgbBmUnyQr/NL75Or9N1OSBM1A9bOgAOGeB1kAL9+1uoTeN+IaxQ9pdevZsiHqirWot5Zjgv1t/GIP82pw39OXmwm9W4oBdzAPsOTHXlqkHHvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268533; c=relaxed/simple;
	bh=6sPJoDSdCcLSNb4YZX1uM25dYeyiyLwAh3M7tzgwDMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QslOLGm0+GU+7dZz+q2d022Rc2PqCpxR2aqPAwYn/UMj934q8Ai0fLdNW0IRny0zsLWj63gKtnkoeCqtGu/G42l7k7p+f+EXhw8Gvgxj+FuDHS4ZBhprwLCpMuV0pNnxzhnEC3gp8aZAFFun6sF4l7gQ1zq3QBwHB9SSGBO0zng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTd5IMyz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c14016868so304208f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744268528; x=1744873328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgLyB76w0gcP39GV2XV9QbhWppqwOFBubIrp/4UCNt4=;
        b=gTd5IMyzRCp+VFmyDgMDe+pzE41eGu+k2axf/nrfXEJUa6uvmx1T9WhHixSxAFITFE
         n02lX6oKzttbmJiH5hVNR5OM1eTcpVluI39uObpE9X3IBhwSgwhds8nJfWkzufJpLACl
         jI1MP9dHkIinEsLfUXx4HWlnlQxe992cWU3A4vquSvTY/ExKDR9zbPCTfPGiGeZAKsbd
         mifzERY9m1WKVcazwJB+3knttTVZ9Tu5fsq8E0CYMIG9jw3DUS4Ik/tJ+j/dGEjvGxCp
         xwVBABx9D/RJiW0BpRb46bLtYW7Au17c3r1B0Hpj75Y1D/RzEihiWDpc68LCyRoMgWM5
         s+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268528; x=1744873328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgLyB76w0gcP39GV2XV9QbhWppqwOFBubIrp/4UCNt4=;
        b=LkxZ7vDguvWc7iIxNOqwkqUSyV7Ef/2sSn8BxTKwvNgDQkdc6E9U4d1e9Gq3MamxLU
         oC1vlsBRKagpGMAt7R3Q0crsvaAuPzLaQa6PLCpiMiEJS8mbhQrs6ARLCUJn/dYpeeAQ
         idELaQMUUumEckEk3lkreCshybHN8OuFMO1xhbMrKAJqzG4602spPhxlQ17C1JSig0/K
         JhPUVHtJEZdXO7mN63m54ouDywKodmLRHJIrtELhiaugtVB5+EcwzqkynEpd5RMqrX/Y
         PeQo20OxWDntNiR9QlIFbr0utG4NLSsqMTkRtr3+IK5C3pCO2yVfOuYtYyLuL5iJ6uyV
         +o+g==
X-Gm-Message-State: AOJu0YxISlbhhpGHYp/yZwGwnV99ljUwzqZYjZNr82/yzpafLuR0wzW3
	/fIpj7EehQzPhhrbkZ3VnqgqyEgNRtn1J+z78i0NTZdET+GTLbl7+VRMCvWX0b4=
X-Gm-Gg: ASbGncuWGlAfp/AGeZtKQtaZWB/z8//2Wux3fWy4HwAqeRP6usrHQ0wP/hEeG8kHPu7
	nXEeoXptEYcNSBo+g5Mbo6/oY7yVqYt0y25rqhSlfYd3aEPvPQy5A9tMghkZipwGbcB08qENKGq
	ArcqivQ966SCvl4/rQA5tHCw9QBbn2nXiAwKY9qKa5qXw9pKE65t+1pYcq6qLZTm63SkVqaPFHh
	R8QW9zacbK9PYzbvkC3I0qfcAW8U47FByRZmFvSppvK7mlRNEv3vUM7yFdFNtA6rLtvx9pAShmt
	LwgjhTv/gRzXHukuL/57PHkC3k/agnXUPbeGYU0nulW7kQ==
X-Google-Smtp-Source: AGHT+IFFDJzRolMy6fSdjlehSMT8Cz0/fTG8bLShZz45R41zW8Xq1JfPfu6m64TYP2VCR/Il1HSn0w==
X-Received: by 2002:adf:9dc1:0:b0:39a:d20b:5c14 with SMTP id ffacd0b85a97d-39d8fd8a268mr771526f8f.36.1744268528562;
        Thu, 10 Apr 2025 00:02:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d893fdfd9sm3879676f8f.92.2025.04.10.00.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:02:08 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:02:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] cpufreq: Use __free() for policy reference counting
 cleanup
Message-ID: <765545b5-f278-47a9-8a67-904cbff177c2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rafael J. Wysocki,

Commit 5b90b0ce2705 ("cpufreq: Use __free() for policy reference
counting cleanup") from Mar 28, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/cpufreq/cpufreq.c:2562 cpufreq_get_policy()
	error: uninitialized symbol 'cpu_policy'.

drivers/cpufreq/cpufreq.c
    2552 /**
    2553  * cpufreq_get_policy - get the current cpufreq_policy
    2554  * @policy: struct cpufreq_policy into which the current cpufreq_policy
    2555  *        is written
    2556  * @cpu: CPU to find the policy for
    2557  *
    2558  * Reads the current cpufreq policy.
    2559  */
    2560 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
    2561 {
--> 2562         struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy);
    2563 
    2564         if (!policy)
    2565                 return -EINVAL;

If policy is NULL then we call put_cpufreq_policy() on an uninitialized
pointer.  But this function is never called so it's dead code.

    2566 
    2567         cpu_policy = cpufreq_cpu_get(cpu);
    2568         if (!cpu_policy)
    2569                 return -EINVAL;
    2570 
    2571         memcpy(policy, cpu_policy, sizeof(*policy));
    2572 
    2573         return 0;
    2574 }

regards,
dan carpenter

