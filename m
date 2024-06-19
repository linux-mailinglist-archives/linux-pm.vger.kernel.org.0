Return-Path: <linux-pm+bounces-9531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837B90E1E1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF38F1F232E1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25919288DB;
	Wed, 19 Jun 2024 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoT4kOT2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92421DFCB
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766977; cv=none; b=DDoErMRs9jGDU+JZxqr2QP+WOQnKoldwhjRUDoKULxGDeNBPl0O5ijOvxOR7m4Rewy+PuFHayoKUgoEO0IWK4RKu/BKrxpPpt3HkknywErchaG6WyX1fjjXZjeOZD1ywgWg5ucGKN3stPGzW+f1dEZkGGnTbnKLO8TBp0s6GcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766977; c=relaxed/simple;
	bh=70o7K5jQp3qCO2paDWj4TSRXHc3qmEa5Sft5Sce2C00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaDrCL9dnvziogObKpEf9eC5sfXjCQp7ngGnNxvcOj5mCzxsFWJrTxjmxWZq+LGVBKPTB5NXbQCqSrvxLs9WdDO10jG2OkIiXrNikMSEkbYkvkFU7ktvVm429z1TBYGREmDjTxxKqqzdgkSYrC8iV93P9cj/qyTGyUkl4xoVRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FoT4kOT2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so3239785ad.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718766975; x=1719371775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7pRdfbAX4uRhBpzI3kNcS/MftxJmx3MFgB+9fN7FI+4=;
        b=FoT4kOT2L758f199ymv6bBknZrTEa5dIRGGQ3UW9tn/QJ/8sr0cFLgSwhbEL2iTrF5
         d1zF15Dpn1BzTV4hcgg9bBttv7TcdaQF1MQvA9yt6NOye+ypt8iWDYsKctKINK1CGMXG
         qKr/hwtSh4Gs37lLa4WqQM9OKFI5/6GVSQsf5Di2R3/THFAfAMdfQdTBr13wK3wUBFiF
         AYBM+0W8XNMjPJBCW71R81rSPwjr7VW/ksZ4ly0nOkBiyNwalCCEsuHdQU2tQ54bqT29
         bqm6I6H3u9me1gsxaoj1/Dh+VopxTdm8RlTqsP+phmchjdm6KIL0rR1IWUxcf6VhQ0Sn
         ZMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766975; x=1719371775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pRdfbAX4uRhBpzI3kNcS/MftxJmx3MFgB+9fN7FI+4=;
        b=SD1aAv6cm8OyiuIWZvR7b2d/sMg+VFWmgtXe4oe7SRRuBZw+Xgx2WULDK2wSB+Tk6T
         fW49ZY6jY3sa2uyC5FRON+0/YkMx3hOtNp9HQoVER6qlxACGmT1yx4UFUWZ7YYOKLrdR
         p6yaAqNmxOx6F6F8e4l2LHTkCrWA1/oZMsN9saLb6m6S1diKdSfb87CG6JnoxEcD3+Ou
         sR7cjO0s0RnVNx0Dl3HRowd+cG5KbFOe6/j2l+ZjM7MRdUz5VElFPh4/b8N5RVWDmEMA
         3K/oBvs8UwzxPPIvrY8j6prOfG/1+oW4ZjwGX0FuUd4HuKld5bSxgNMBx3q1HzwkDrD8
         EqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrQy9JKZ/6R1Zh5w7voIW3AOi11i2LNPjqLFZzx6ACVTlLRwlACoJbJPbO0vLw3/+glchgz71vr4sxNT0NP0FwwG4E8vT4gm8=
X-Gm-Message-State: AOJu0YwDyRkFtvG+amu2F0hSzWOK0jX4PnYEg83zuaB3yMykOSZLW1cQ
	4lJfKA+d6mJ8GDsLw1go69SyIyrJCzb/pCQHtY/EtRY05nz1BjBBLJ/eNxz8Edc=
X-Google-Smtp-Source: AGHT+IG1H/m3v8hmgPXuNYLHmkG/3ENRpPzfQEQ+VxQcJ425m8/2HiHdp9gAl3MGHr8Qygz+XE4uiA==
X-Received: by 2002:a17:902:daca:b0:1f8:66fb:1679 with SMTP id d9443c01a7336-1f9a9274fb1mr23236235ad.30.1718766974750;
        Tue, 18 Jun 2024 20:16:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f85b4eca1bsm101487975ad.146.2024.06.18.20.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:16:14 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:46:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Ryan Walklin <ryan@testtoast.com>, Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: sun50i: add Allwinner H700 speed bin
Message-ID: <20240619031610.t7tsls4ub6vdluvq@vireshk-i7>
References: <20240607092140.33112-1-ryan@testtoast.com>
 <20240607092140.33112-2-ryan@testtoast.com>
 <20240619010021.5962e459@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619010021.5962e459@minigeek.lan>

On 19-06-24, 01:00, Andre Przywara wrote:
> On Fri,  7 Jun 2024 21:20:33 +1200
> Ryan Walklin <ryan@testtoast.com> wrote:
> 
> > Support for the Allwinner H618, H618 and H700 was added to the sun50i
> > cpufreq-nvmem driver recently [1] however at the time some operating
> > points supported by the H700 (1.008, 1.032 and 1.512 GHz) and in use by
> > vendor BSPs were found to be unstable during testing, so the H700 speed
> > bin and  the 1.032 GHz OPP were not included in the mainline driver.
> > 
> > Retesting with kernel 6.10rc2 (which carries additional fixes for the
> > driver) now shows stable operation with these points.
> > 
> > Add the H700 speed bin to the driver.
> > 
> > Signed-off-by: Ryan Walklin <ryan@testtoast.com>
> 
> Yes, 0x6c00 is the value for the H700 SoCs in the devices we have seen:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied. Thanks.

-- 
viresh

