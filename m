Return-Path: <linux-pm+bounces-19408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3C9F5F71
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3EF169C70
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460B156F5E;
	Wed, 18 Dec 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKQMijE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530E8488;
	Wed, 18 Dec 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507669; cv=none; b=Lt2Dmi7oNoyz8MkRMpGeHaHW84c7Tl1OxaX7K6kfsjGtuFJpzJAT6j1lTQ96v+GZkCLJKbjlXTeJgLwNPsyRRJnCU0aCpguUCsvHeyUV9ubcU84sWTFx1NN0TBAgkiP8X23KWu7IYAmJy7aIZYZt7/58iIXZBxPYtD3VLG5pzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507669; c=relaxed/simple;
	bh=4cfJwBLt5YiYGCu7Src+VPcU2ExVwuXFHWilXZMjjHI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moyJwluKJtiwStLpZywzLMx0UOAXeUbsgyq0PrZbma07euleKUQNvTvmYlwQmTRyIIFVG8cZYFUL8/K0Y+rca7HjRfGloJN8nF1U4B1p4zzejsmUyGRyTFRj6WqkBE9iLCQO+vewB5E1FWf2TCv85aeK612GRv6YS7TsrkuBYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKQMijE/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38634c35129so4655728f8f.3;
        Tue, 17 Dec 2024 23:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734507666; x=1735112466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34XET46P1ISruACfQ2TDcg2ELpP+TWScTu9y+D1NkoA=;
        b=nKQMijE/OzTKgIJEtKAm1wWMi92/+b+D4+veha44YY9ZRLOFedKv9THAIaHOTpEXeh
         nXEaq44VNIfuTXyn2PxHNx5JH8s6jpIAXo1IIQmhwXbEvV3jzKKjyL3lpK3658xAm879
         I4fmdzW+F8CCbDEp12V5molvrfx8N0ORUj9J1XYGkHsUWgsmHOpyECuypFS3Bw7G3jq1
         WBdwgPInRr/kXKOyx15FpbWvFJ2ff+jwKJzZ+kjamhhmwrjmhpgNycWobtWslzFX5rac
         9JZ2NkC65nnoeI2oM+kXX5Te+8gAvomxKvz7X2+7qHJ7QbfPg8CyVljBQkzrSHdaDsHF
         sh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507666; x=1735112466;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34XET46P1ISruACfQ2TDcg2ELpP+TWScTu9y+D1NkoA=;
        b=DW3LPyNIR1T93JJYI95or1VMlpb+ypSnw6U04SEoHGanAixmia7MDh/9Bhmcmc+pgu
         rDFN0wjNQ29p10XmI12oVqBsHJsPc4E+uSvrgsYWECPY7owz0o2cQM/hzZOQRIJafOBL
         y7zxQX/h1AzVkcF4LFoTcRfmSd/xOIoWxXG7947c5eHjyqQ2ODDivknSKls0DHWOwf7P
         ZftvpVZsEKDHHXbSCPwHyqNZsddpZR9hrWCB+4ZaKYtUUEa9pqQX1MI0BmFdatfpf4Vw
         xJdbc6PNtGDoPEBxTP/bWTl8YCZ4TSp2CRaLXUhtOPXoSo8ooIS5WO5k5TGjvhQxFUoY
         eXCw==
X-Forwarded-Encrypted: i=1; AJvYcCWwBXWEzRm30WV4HA0vFkX+OVxE+CVqLItfSTLu6K+7qQBTyUeab7+JgVRrV7NE3wIz6pa6fcA1UfmY+Rms@vger.kernel.org, AJvYcCXNsTxiozyicRgWX9R9y99ccxjy3pcheHVibpruneSMIpK9agwcg259kcxz+PFA7rlH3VNDbWUGbRJ7@vger.kernel.org, AJvYcCXRqfgzLOCATDpwoV5lSfKtRZRSeXbAhMTECjxS2JXNG3zX7v+1xn3WPdfs+XTS8/GVTa+llg0ZAtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFDzH5PkVbwjJ/uuMtTDMHVBnidIi97R3ca0uzW16kyenAFQO
	4VEP0t+qSp25FAz7BGQkeXFLlKERjeF23lRzSmbye0yWBiUtnlhtXEK5Yw==
X-Gm-Gg: ASbGncsvObPw7NEmT9fh9ubE3a7Trfo7tAFIXyv1BYhmZkwq+sUZUVCzBv/beq+VB+A
	Naoi0X1O+DoStl312+gc7u7QqnVW4+EosUqwnL9BSCLAJbkfpmKQsu0c4a1/Mh2PzcZTVURouWw
	Hu4BqVVM+HVtg1AbAYHPZJoT6xLNrRzp8eL4yNWJn35q4OFT47bctI7EQh/yaweH3WEoDAQyWZL
	S9KSXtIi3fs3a4Nzm6+p8FEUZozTC8FMta4DJ30+lRC3fraaL+kuiDwLec55tIaJ00vIqk6B+ld
	V1CvpfV5+eSAHRPmWNQfo25NJ6ISUg==
X-Google-Smtp-Source: AGHT+IGDB4+tIrlRIaSAkWFDRJW0gCTT86F1KHgVhII4jSgkqz6NO+NbPDCzmNlPgh8ZMEmRgM84pQ==
X-Received: by 2002:a05:6000:4615:b0:385:df73:2f18 with SMTP id ffacd0b85a97d-388e4d9c44fmr1420125f8f.51.1734507666132;
        Tue, 17 Dec 2024 23:41:06 -0800 (PST)
Received: from Ansuel-XPS. (host-80-181-61-65.pool80181.interbusiness.it. [80.181.61.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80121d4sm13575199f8f.2.2024.12.17.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:41:05 -0800 (PST)
Message-ID: <67627c91.5d0a0220.ce2b3.f329@mx.google.com>
X-Google-Original-Message-ID: <Z2J8j_jJ0ba_szmS@Ansuel-XPS.>
Date: Wed, 18 Dec 2024 08:41:03 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
 <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
 <675cb6b2.050a0220.149877.5bab@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675cb6b2.050a0220.149877.5bab@mx.google.com>

On Fri, Dec 13, 2024 at 11:35:25PM +0100, Christian Marangi wrote:
> On Fri, Dec 13, 2024 at 09:30:01AM +0530, Viresh Kumar wrote:
> > On 12-12-24, 13:01, Ulf Hansson wrote:
> > > On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > Hmm, it looks like this needs to be moved and possibly split up.
> > > 
> > > The provider part (for the clock and power-domain) belongs in
> > > /drivers/pmdomain/*, along with the other power-domain providers.
> > > 
> > > Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> > > 
> > > To me, the above code belongs in a power-domain provider driver. While
> > > the below should be taken care of in cpufreq-dt, except for the device
> > > registration of the cpufreq-dt device, I guess.
> > > 
> > > Viresh, what's your view on this?
> > 
> > Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
> > the cpufreq directory.
> >
> 
> Problem is really DT schema... I wonder if it's acceptable to push a
> name-only driver in pmdomain just do detach from cpufreq. The cpufreq
> driver would manually probe the pmdomain. Is it acceptable?
> 
> Or do you have alternative solution for this?
>

Hi Viresk I notice the DT patch has been applied to -next but no
cpufreq patch. I'm confused how to further proceed and what changes are
needed. Any hint?

-- 
	Ansuel

