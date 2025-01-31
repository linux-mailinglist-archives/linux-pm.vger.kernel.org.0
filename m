Return-Path: <linux-pm+bounces-21168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2AA23935
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 06:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F3618895B5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 05:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF453E23;
	Fri, 31 Jan 2025 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQQRzQwm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEE1F94A
	for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2025 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738300136; cv=none; b=Zi4D8q4L6m1tLFUwhfmUbWYjm0haZn3PFHiOCEML2nY27kVrw4Rsgdh/edKy9QliAfocprgSKCuJyGcwlsw9opQFFVFmiDcVTw3JRBr4M4a67+UpmIQ3i3YG9zvfAK3ldE9cmSwnmEaM43MO0VSPJl0jcsr0/bT9+vM8Eara8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738300136; c=relaxed/simple;
	bh=/h67jHK1llFod+55Grj2UdY1TtIg/nzLGcQvP4Bfffc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/M8OGvkPlaTfpVfxti2ZD+QaNkKNarz4PfOhtn2JIesdq4k6C/kK71DRmSX2lPWIjPEC/pmcRBqdLv8O2GoXCnfx7ZmiFyJRfohHZ/V+yPsTMODX9BF6JsJyhxqCto00ynvYS7uAkY5YqSWEj8ndhxBXP7a02CNIXibG/39Hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQQRzQwm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso27388755ad.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 21:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738300134; x=1738904934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0RM1tUSuNCnllkvRNHONUGOjOBTzrfgAw5YZHNLGX4=;
        b=NQQRzQwm2v43+OFBMrJ3wTgmBEgoP8KvftgvaDG3KKz/+/r73TRcN3d4LARhhd+i0a
         BhhDSu1lOeIgXk4c88dJVtbujXOv1bPyVTEenGrvLmGawcY1Ik2Cx0cDEPGo9tLm91S1
         FCR7eihap+i26XG62RjFZUcM6C82bMI7Bibt+NMAlXSOmp0ejQyOYMSn7+QRBRaKn+EZ
         uwUf8dvkF7euhzICW7dM/pCjVbKMDZ8rNOzdTw4ul81QFPIGI0vBZNROmu8+/uzRnqS7
         3mhwJtHIRJmr1qR4gUS/gbVY4QYt8+rlLoiGbEYMhUjWwEnr542qzQUaypMApCsZ99qS
         aCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738300134; x=1738904934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0RM1tUSuNCnllkvRNHONUGOjOBTzrfgAw5YZHNLGX4=;
        b=Est/UJId4kPTX4h5JuwRnoLTIdQDEQJx56VHQ4uoHHiTeJRPX7sXQScbxdnOdVWDhW
         aa6jbZQy58IAq91HTvSVDW5IXV2/Lddoe0z2Axx/1SmsVH+vdGQhtnyKAOF1tBurYB3j
         6WtGr1jzk/4uM4TgLUuhaAyoLw5iEgQQbg+5oz8o0PbWOPm4SaeKRW3WzO8p3qWtNFLe
         LVr4DjeOURt2XmiPpegyX1BRoKxCsszUShFwuYGNXcoaJXuCqdzelCFibKmnJCZYCYrR
         Msp65PW3WcTUk4bMiSmUCzKpHJxZuLLS11eK0pNyBjTj9qvGfFtXFUcfX7zu1ea9sPcU
         wH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVSLomxGCQKWDLwsJBX2yUBo9kxcWnmQzlPo9EOHMNHQvuPuXVTgNQzz5aHBX8LqmlK6UKebipqrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjP7zNgseFovhZBA9xTg2L0BPH5zemHItUyaPcM6tneO7p4Fc
	v4WQ499SnRpv1CBbHS9TsEMwuAfxVLAxhKZhETeprfRSGm791io4fa8RfLmTq1I=
X-Gm-Gg: ASbGncvdhiQqIioLG6aftbqbmYnwNbpLNiPVEIeldA1Pvi4nw8250R+gRVornC1bwTi
	OU4vJUf9lz16JwHV4GKn8LkgRD6pqrE36gLvMo/wNmkXnusXyL3ZIs7t36Akcapo/5jDNf0ZG1H
	jT1Nac0ekcMP2OI/ug+sPdZ7JRaMGGiaU7ietOl+pj0eV8k21sUnsQElH4q0nVDF5VsNeP6Vl8T
	PvgShpECnChDWMS6cFJxpi5YSIZJMSNc+Jh9EmEAVC6O9VW+PJvzxG3Fatn/XAb1K6vyy4czhN0
	nLz5yGiRPHGTpVdeDQ==
X-Google-Smtp-Source: AGHT+IEC3ww0r8QRW+a6btmpKJJf+PSATOYvFliOp4lwrITNggyBPL2vRRp5D/mtRXbcT719OdHweg==
X-Received: by 2002:a17:902:ef43:b0:216:45eb:5e4d with SMTP id d9443c01a7336-21dd7c3d30dmr123313215ad.6.1738300134193;
        Thu, 30 Jan 2025 21:08:54 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm22514295ad.140.2025.01.30.21.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 21:08:53 -0800 (PST)
Date: Fri, 31 Jan 2025 10:38:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	mario.limonciello@amd.com, rafael@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove unnecessary driver_lock in
 set_boost
Message-ID: <20250131050851.uhe3sc2pnvrcsx2k@vireshk-i7>
References: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
 <Z5xaXwMNXQc+qbqq@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5xaXwMNXQc+qbqq@BLRRASHENOY1.amd.com>

On 31-01-25, 10:36, Gautham R. Shenoy wrote:
> On Thu, Jan 30, 2025 at 08:52:52AM +0000, Dhananjay Ugwekar wrote:
> > set_boost is a per-policy function call, hence a driver wide lock is
> > unnecessary. Also this mutex_acquire can collide with the mutex_acquire
> > from the mode-switch path in status_store(), which can lead to a
> > deadlock. So, remove it.
> 
> Looks good to me. The driver lock should only guard the state
> changes. Everything else is a per-policy change and is better guarded
> by the per-cpudata mutex.
> 
> Once Mario acks this patch, please respond to Viresh's series and let
> him know that this patch needs to go in before his series. If he is ok
> with it, he can include it in his series.

Yeah, I will apply this once rc1 is out.

-- 
viresh

