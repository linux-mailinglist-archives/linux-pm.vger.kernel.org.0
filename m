Return-Path: <linux-pm+bounces-27652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B86EAC3E2F
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0444A16ED7A
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2931F4725;
	Mon, 26 May 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBL0RYtU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05514AD2B
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256884; cv=none; b=XCpx05VZz9l1DSjfOw+15YbHmsCTx2uhscI7wnkbtUc3WyR3kbW41n+VUZXMWvrZRq8YiWDHBFzL/8se076YV1kP3sLQMxRXEScPhBuYfTHKbEM8cRqLy5wJn1ggE2IOGjENkvXH+QD2+JREfdiM2IyXIWh7odiwtKP08ELaZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256884; c=relaxed/simple;
	bh=WoRRDE7tMT6ju9+8BJZvDtVb7dYNA0fgQEcnW7e3AR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQhahIaUNou/1isv/BYV63L18fJlKLeseOoDSoidt4sXGSAM+hqF///Fvo3SVQR2+jAiBO/6AL9CYJikjIPzoqIR3caqqQt8OHkLAH2fV/8EANA7IPPCKVEpLV1xPy9lVAzHNV1rZrRnwOxa2cznDJAJLukO5suNI6cn0RvlwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cBL0RYtU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22d95f0dda4so21162335ad.2
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748256882; x=1748861682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLCxic84uJtwU//3LF6ddUkS7r9eUJOZDNLeT51w6NU=;
        b=cBL0RYtUc3m/+Rh0xKItEAwPHesWTR0V7rgbqbshN5m1Hljxmu1Mr+ZusFoaEx8Oyg
         7KipxW2RW8vWbpi47mySNAYcR4Gpz4hTZCfLmfdjJP/JoOVI7sN7iBCqagLIAt3W5sQh
         JyU4H4qEH/oPIPMc8nJhiDnJ2sUHxR+7iX7J03j4wt2W5A5gM+6DCUWsLUrhsRzABAvz
         T74Kzb1U5ReEf995sUpYAgYZiCFB6jB5tnfunsRKK6vi11MToJr2U0oZkJWRYxwyR2jg
         4AhwfjK2fbqscTYbm6qnLFB7SDvKi6lwrxASUyFQk907iZk5pBqbKmG3XRZm04Q19brG
         mt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748256882; x=1748861682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLCxic84uJtwU//3LF6ddUkS7r9eUJOZDNLeT51w6NU=;
        b=drHC2M24qkkw+QXJQZZcLJk5aaxXb6akaqNOMZd1KMvoPaguJnsBeL+SDWZaHu8JHi
         VVpYQ/nOEsxcV6mZkQJ66FFFzLD8rgwZ+QmCCPClU2rHpJzufC13UibLiCIc7WXZLP5X
         b+UDAo7uFWx2acSEH559qbTVJG6lCKggXgPep1wgc1II4qv7zXf3VdNBCmweR7gzUnD7
         29gt2tB4k3mTgMv7vJl6lDEpcUa0Bmv+UBAtPvdu2iPsz6tqlonGm9d3RaqJ+QIpXxf8
         JbdGPkNw3vQ4kInu8mz5yZG/pe9WamVksbZRAP4EY3TFPvO+YRg3glYS1GXEbzesjjTt
         xTSQ==
X-Gm-Message-State: AOJu0Yw3KxzPMCIpNRgPF5FymROBC37/A/2OmP3RnQ0P+ZHrvBmHfW6H
	TIQ/Wu6FpdoyhbcHMXDJxnjYrJddlw/LdXkH8IQGB9EgAvxoSXOb4bXozfDoTxKLRVjk+7Zoi3Q
	2En3U
X-Gm-Gg: ASbGncvBVQ2QqXrWzH3k1l9rCVC3xcB9Zrxym/gjciPx96EMfpYAs7o3K+LF2LnYq4J
	I7xgb753kmSJP0xqIPCPoqpfJmJDhORJX56M/LE/PIQvuwuU2awXNKmGhX+vE/Ju9tsyc1UCGcH
	RFSEGqLkEWzzfHwpQlff1AnHr9fGqjExRl2cqCT5gZp34ujBXhd/nGS7GEA+hRYXWxKj75KAoyc
	0aX0YTXQkLN70VF63xW70oeA09G0TKcUX6zymt20vpzkuOfQy5SJAe6aT2xC98UbKq4YbjEMrtC
	eLETALmS6/UPzmr3+vKbxsU7WBbkvKyCkAOCwqgkfoiNPvI8YDKq
X-Google-Smtp-Source: AGHT+IGCeaICQqcTOZvKYH88FEe3Fu+UqQ3DRySLa3lEHif8v6RPKTT7qsMgExf9t/iMecbP9pww6w==
X-Received: by 2002:a17:903:19f0:b0:233:ab04:27a with SMTP id d9443c01a7336-2341500e3d6mr151462825ad.53.1748256881847;
        Mon, 26 May 2025 03:54:41 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2342d6cf012sm30999205ad.96.2025.05.26.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:54:41 -0700 (PDT)
Date: Mon, 26 May 2025 16:24:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] OPP updates for 6.16
Message-ID: <20250526105438.fvgnvqdgbm5inlal@vireshk-i7>
References: <20250526063647.ydi7vlqdiguf7cof@vireshk-i7>
 <CAJZ5v0iEts2_SBPi4gV5TzUP0K-9-Fy09qBJ+V75E9U+SCyPMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iEts2_SBPi4gV5TzUP0K-9-Fy09qBJ+V75E9U+SCyPMw@mail.gmail.com>

On 26-05-25, 12:44, Rafael J. Wysocki wrote:
> I gather that it doesn't depend on the Rust material, so it will be
> included in the first PM pull request for 6.16-rc1.

Right.

-- 
viresh

