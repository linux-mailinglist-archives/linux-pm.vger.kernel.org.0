Return-Path: <linux-pm+bounces-20675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E63A16802
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6AD16A46F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4151474A7;
	Mon, 20 Jan 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMSZ7/Mu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963018FDAA
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737360913; cv=none; b=N2rs6laiRweGG5/dQPSHnJ0YJCi8pMrU0KtzKaKJV71++cOSb7XFFceFToG/DNZDQttdacYPGH86VvNlNPYc/K3NKuK2Jug4EV8OqjjAZEWHDpLLO7RTxbhY+ekLoHFBSxscMHWAO6rFWvbXCNNqNAtWt/D8z96nL5D1PWd6FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737360913; c=relaxed/simple;
	bh=qNU2pgojq4RxHg/p3aNjSgeJllAWkcFz7GgDPZJb/cI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IzPGOxmyNSwSj7MlF0oKHRUIBUeuupYgOJinjwqympTpg2MtcYLQ13F8aaaLn/4iFf20mkIfIrNf61cCA1Z+w+1UMtAGiEa5QDv/8Wj4PnfJT//ROwGPI1rqaEOLjNkr8kx3gFnoTYjHpdCrOAhr500koVoPywS+Vb1ExhQfTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMSZ7/Mu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso25889725e9.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737360909; x=1737965709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A09ktfAOPPyu9exFxifvfSR4TKmqpkMAIRIJNi7aCSI=;
        b=iMSZ7/MudDttnuECrCN62mzoQCTmkNJCDCLsoyaM6d87EDunyhUkqJArFu4C/563Y5
         M5VBXcwUjyl0JvPLKDCsMcni57t3zl6cGUlXd5o8iDnmmBnFNmNswnAfIe2Kv89kkOXn
         WVIhj6An5apNFTvRqg0rT01j1rGvaJ5NgvFS5Bqbgern2TABxzMr4ca0PzdCFFErwmly
         gahmnp0eT7czY5ljeXJFCU55mcyCRe76jINEjnYdL34mUJhT6rrsPpiyRTJyPAqu1bjj
         gy2vTy9jI3uYsswgQJz3zOnRSGOw6aGnoxRZCzMAzDUSm2PrlrX8oMcf2ejwKIpe1sij
         koWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737360909; x=1737965709;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A09ktfAOPPyu9exFxifvfSR4TKmqpkMAIRIJNi7aCSI=;
        b=lW8LDrTLKHQMOR92ZSZsdpymh/5g5twlaL7n7qsKgN3GRnROra6+omhTScIIwbU5e0
         5tTS6GrVNmUIICXubxZ3D8ONVVyDt0RZZmSYU/LLrpfmEv9sYpz2wDqo4FHiEN5D66UZ
         Xf7hiQjv/EiJxicDE5cXPo9AWoKW7Zh312FZIGF9DYIxPkp4evDm61GKK/t2Xh+fLxQE
         fxTHqUKV0nFub9XZyhEFwkhDjPC7m3JjYQ7e8M8kCdahlfCL8cQc+Yr6PHS9NK/6cItV
         a/J0e+aN2vbxN9TSaVwz0OrNn7n3qd+oUI5LYpITcAoUVte85p47k8Atzn6gZSS/620g
         az+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/ICyeiye55alpVem8Ws80VqL133ybFbyp5n+j5eWAeCKOJQ2hP1dGL2Nl//ztV68nGU85wouIdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgsFiArS26WDJZ8GdPxIuLml0B51Wu88SkUCTNAq2+9jWuTpT
	7samzkp8q0U1ghXKk2RGe5emv+PuHRqzsdmFFTwybnyNHz2torz/dPZBQBQBwgY=
X-Gm-Gg: ASbGnctwUwKqVHrlIyC0ftb9QjqVs+JkrcEuuo1Q2elhcWEUAL+5hckScDzg+M8jlWc
	7aDaekMrFkdAV1FPOdsG2c4UvFwiftIcDl8Lfj6jyjgostvUxj61KIvSqkO3pfKZIf6uBY+kaP4
	MLME/NzJ9/nXzNDngQzAw1sQ7eFzOewl1Zd2niail6h59GQKW3fgnk6RzJq4SXEgyxCL0eYfnPS
	jFq/JBsPT2xSjXV+FkSIcayyhw6asgfmoCLiwbv6T8Q7ifIFvfadhoIho54FWaQY7hHiae3kOA=
X-Google-Smtp-Source: AGHT+IEWHv9ynMnrEE8ZJOOYjOCTr5BrSCFg9p7EuLheqv8DchREXYYPN0l/9TjEXyDyPhS98pE9uA==
X-Received: by 2002:a05:600c:4452:b0:436:e3ea:64dd with SMTP id 5b1f17b1804b1-437c6b2dd76mr176517855e9.11.1737360909177;
        Mon, 20 Jan 2025 00:15:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890462195sm128375705e9.30.2025.01.20.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 00:15:08 -0800 (PST)
Date: Mon, 20 Jan 2025 11:15:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Mike Tipton <mdptipton@quicinc.com>,
	Vivek Aknurwar <viveka@quicinc.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation
 support
Message-ID: <0bca7854-aa27-48c6-8612-bcecc7b68c65@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111161429.51-2-quic_rlaggysh@quicinc.com>

Hi Raviteja,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raviteja-Laggyshetty/interconnect-core-Add-dynamic-id-allocation-support/20250112-001756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250111161429.51-2-quic_rlaggysh%40quicinc.com
patch subject: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation support
config: arm-randconfig-r072-20250118 (https://download.01.org/0day-ci/archive/20250120/202501201530.UTAPd4lC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501201530.UTAPd4lC-lkp@intel.com/

smatch warnings:
drivers/interconnect/core.c:889 icc_node_create_alloc_id() warn: inconsistent returns 'global &icc_lock'.

vim +889 drivers/interconnect/core.c

65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  867  struct icc_node *icc_node_create_alloc_id(int start_id)
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  868  {
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  869  	struct icc_node *node;
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  870  	int id;
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  871  
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  872  	mutex_lock(&icc_lock);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  873  
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  874  	node = kzalloc(sizeof(*node), GFP_KERNEL);

Do this allocation before taking the mutex_lock(&icc_lock).  Otherwise
you'd have to unlock before returning.

65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  875  	if (!node)
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  876  		return ERR_PTR(-ENOMEM);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  877  
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  878  	id = idr_alloc(&icc_idr, node, start_id, 0, GFP_KERNEL);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  879  	if (id < 0) {
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  880  		WARN(1, "%s: couldn't get idr\n", __func__);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  881  		kfree(node);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  882  		node = ERR_PTR(id);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  883  		goto out;
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  884  	}
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  885  	node->id = id;
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  886  out:
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  887  	mutex_unlock(&icc_lock);
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  888  
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11 @889  	return node;
65971f5d716cb8 Raviteja Laggyshetty 2025-01-11  890  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


