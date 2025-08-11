Return-Path: <linux-pm+bounces-32117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA2B1FFA9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E672A3B115F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 06:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048D2D8DD9;
	Mon, 11 Aug 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxAknPmB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08E2D8796
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895213; cv=none; b=ksrTW2ro7HEPVM9ojrzecQW/GN9yGr5v4EDkgPkXFqf0Iwh9OfMechpTxmCG+h6VbpDD49Hft9LOf28Bwevod6hdWOPaI4EpFPkJnGHiKRscEnqjnEMQpi41dfw036AiaQp2HplfDBxOcpOus9TN3CwQiHO6fTBmeWS+ERgd6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895213; c=relaxed/simple;
	bh=s67MicxTyFJvpq6HlkPwIjp6fTvRqRqA28FzYgVvHjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ/cky6yEpr5HDjONfjDzshBWriAMwMxDUcXrfcjYLbfXG2ctqbu1jdpiIqPB3KQEbJEEQNFSaWsSEgT3qpatJ1TlH7HwvCy75zDI8gG1EtEqaZnBolysM6iBHoPHENb4FXzn7Sv2F1kXRNN18Lc0PwQva3ggXXwmdX7BIdEbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AxAknPmB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24003ed822cso22909615ad.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895210; x=1755500010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0BX64TErFoIWs1t6Evpyt8styxu8dJRt0rrYpLp44Y=;
        b=AxAknPmBnmprw+42nnM7Adria8U8ZmLHvGRRRMMD+bLERAL8jfI23ZpJaTy1k9PmPK
         ZVi46TmUO6hlCsi+VIvmc0Xfjnr+EUUEnOb14dxzx+Flx9rvJNPTPmfprg/E25u3Uws3
         8qydAxapuw2Q3xgZd7jWHFzcznPc8CoT68Zae6LZmx996sTXOxfzN4UpDMzfzYjEo3SE
         caXdApj/3WUwwgx4KBNs2YxDP2h6zXOcxsA3wRvlqO1Yj6ofYIRsHCsM+VSzr25ltC6l
         Sf0BP11wtBbpy3ULxR4Sx8GPPpZzEdq5oKgZHxBtEmpbSVGbEq48SkYbwOVplZ5q1vxa
         UfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895210; x=1755500010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0BX64TErFoIWs1t6Evpyt8styxu8dJRt0rrYpLp44Y=;
        b=GHPdJOCfVxi0dOTqJXSREWXyGWQpJ6J0ONcANAOcdBOc7bmpwtsMR4h5qgsggjcGPv
         AXngBP1IscSR8dvVXrdSDXvW16wZI8Ihza0/i/rkGOhyMcMXP2ORy39KEFjDX5RSIdF9
         jbVckzca5hLc48ZdDHtPJ4OZlNW9JUGnNaTD6ZTqyssksJiD5eirhDy2wlMnemIjy3g3
         jZnSXa208azA5bY3odddrL062ZiZ23mPVvERucagfba7ZOn/KrKZ+sK7436YWKH8fD8t
         iwpvjI+1FHd/upPwVVg+ro2yPNIv79+BBdSVvh3afigeLh38TfzVfSUxubpSU1CF4b4P
         i0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu7KowEZua3IdsX3osFCEZ73WJncFtt2dUp7QNcdbnJLP3zIoUzR3Fgjok0pso0FUUEeeEb+rKag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GtkkYzcPbAPQUdcVfeMcr+h2RH9xZV2XpbumQIlR6D23CaeP
	EPA3wo+BjyJG+86VIWa0azhW6NRnnOFGYf7HXfsf8Ar3jSFNatultG1IHvf17M0Po8A=
X-Gm-Gg: ASbGncvwZ41MPEboRH7VahwOBWpQcH1T8t7USapoN6pk7hcavSj1SbvGSihvcmt0jA5
	ayfp/24oZZXyZzAxqb6ODPRZ4+YHXSsQe2DrGGPO7+zzWj4K5zCWnDILyhBM2lgz/syEbtespRX
	8A07a1bemJoaLFrKokmYqXAx0WszP9k7gRuQkeUG/ILR/gyCQNt4U91V5naN6kbE//OaaKGNzmm
	l9lS9uzzeJr9vsMcaDoYPmdgPtqw+8piaQtdINx9vUljn5uenyOS/bTdW5GnrifXytKRsqRbalJ
	k3A8xHK97fChrNBavZ514OqDmUZByNDIZH+U5F3V9hwq4SpBeUALvSJ35w57CH92TNrpIKKkNDW
	NY5UGhSw8oJ9VdArs8Gits6RD
X-Google-Smtp-Source: AGHT+IEIl0S/VOqDSLXuBI4x/e0A22S456H8IOsSLzikWZ8KM0Gi2SPraGYKilSTYjzIMK0FS+Uavw==
X-Received: by 2002:a17:903:3c30:b0:242:89fd:48cc with SMTP id d9443c01a7336-242c224ccb3mr163220875ad.50.1754895210360;
        Sun, 10 Aug 2025 23:53:30 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm266721525ad.5.2025.08.10.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:53:29 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:23:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/1] cpufreq: armada-37xx: use max() to calculate
 target_vm
Message-ID: <20250811065327.m7hz3676vdzivktn@vireshk-i7>
References: <cover.1754747830.git.akhilesh@ee.iitb.ac.in>
 <26e67441fd3e91beca47fb4b6fb2accbe1088c79.1754747831.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e67441fd3e91beca47fb4b6fb2accbe1088c79.1754747831.git.akhilesh@ee.iitb.ac.in>

On 09-08-25, 19:46, Akhilesh Patil wrote:
> Use max() macro while calculating target_vm to simplify and improve the
> armada-37xx-cpufreq driver code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202503251256.rrl65HgY-lkp@intel.com/
> Reported-by: Yang Ruibin <11162571@vivo.com>
> Closes: https://lore.kernel.org/lkml/2c55fb07-b29e-43e0-8697-f75d1f0df89a@vivo.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

