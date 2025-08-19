Return-Path: <linux-pm+bounces-32608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDFB2BB37
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB48167D77
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080043101BA;
	Tue, 19 Aug 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J22lxZ2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2B202C5C
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590261; cv=none; b=NfQQXFJ6tzGk0YS2GE4jWW1EZ5b8QLj1/mNe8cjbvryrEdyexAqQQic468ZnUJWhmzQxSbZMsyAKh41xORazzKeL/da7vH8aL+5/caAZwKl0hgqgdEk68HITMXAng8GCfb6V/TlYeiisO3hHOybKueuTKE/wZi7WvjAAEtYJuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590261; c=relaxed/simple;
	bh=sTqY50ZtfvJHSQsjKEUUxoMSu30ce205UyxUJM6vA8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ra/1HkANfdLUQ8wsjYBP6/qk+Zt05M08Wd703pBuB9rOJxlGzwiOANYc+SMdtE/ef0VD6yXOinAH5+tFYIEwwTuUIYzjEH9StAiFTueC8X0wWFHCuMfD3RWDoUOJhNz9iSfHP3b6lBr20aVCTY66Hcd+/1PcRmw3wg98onISvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J22lxZ2H; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f90376a3so34802981fa.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755590258; x=1756195058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RPJIs0E6D3gI56GtnaiXL9ifszX/gDI8hfE+Ejpxl4=;
        b=J22lxZ2H8k7Yy3jfZkAl4eS7Y1UmYKwtJ85FVzXJjA1cUQwgBWpPW04oC7zIwN9jke
         9P1ETtANORpQkR8RxyKVodJZD0Msc5EykUh3QXNMYf4eS+eaBkbtdKc22vHtOS2xjh2C
         4hC2uHlsFc0c38x7nJx4MPnIOlR5GT0Uc8m4U5VH9nHWEixcwJET3Z9QwxSKR2b3CrFH
         YN5hdmvlCdlgFymO3TPJpHUqOLvvvb2DdM/9aKxEqfjd3wV/7k3T79RIljDkvqbZ8JEr
         LXCEabG0Oyv7GMqnEDwoPYFih769+RloHGynhXc47C/9wMWLWGuBRn0VzJHCq7nA/FWR
         Gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590258; x=1756195058;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RPJIs0E6D3gI56GtnaiXL9ifszX/gDI8hfE+Ejpxl4=;
        b=c3SJHasGcj4x8iIu5m6GKSV+4HKlGf4RJt/NyuQoSXJnwmz9svcAizKbS+0DbeUdQF
         tjfITrAdmg+9pF3plEsQr7Al2pPtVB5Kie7+ueED6VVB1U+/vQgkmXtNPKTfYbjY2XHf
         +LoxhO41s5a/Gkq37CQ3ivNhEYKcSDl3Gdq+5G1Ea1bjQ0ZB/OEbssK1RKYIMq8D+lYH
         Q5pv36pDPmb+wGD5mLHCufBxQ6AF5nDSMLYswMoRZo/ngyXCGyG8DFIAQYd6SuLED8Mp
         eMoBfDD6J6YCt1cK0LEsPHwp7h04t1mA8iz5+B9tyGTqlcdMRLCp60MmQ8+gpNb+LnuT
         HAbw==
X-Gm-Message-State: AOJu0YzZVfX2ATc06c3tYMSSympljjSJof8XI1fmoA3m/Zm2XvSBQaX/
	Y53nhkEIJcTttDE+awy03ddO+z97O4P5PEBcA82wfqF5TU04tfXhqqBcyDanykZ5Hz/PjnNrpbc
	6TdCV
X-Gm-Gg: ASbGnct7XgZtN1fqdTTKwnNj69JPxFlIXUmE6JpsAVq8FXSFiOTP3ivx9U/uFd6JAER
	iwjOdXo4GR43BtZAUQRHhndGGtAuh51KMrFJSSBWaQsIFgvFpswb1VEmECA8dhObFVVx4WkZ+Se
	/MYSZ7SGofmLPcic+ANjJ1hs7m7Pw0Ibwy8eUnBxyeQ8bzjyKt6pKlUswM/7RK/fNN2Fm5Efr/f
	hIh8ZvASgye+YkdxQqVGsMHSeAag7kAc3fh2z4rJYNl2JpWg78TCwnc8lVMGQoQab1tERLuRfv4
	oPjuKNY5ep+OtLlh5lrrl1/7aZxVEuZU4Z2yx5E49QGDgy5hGuSQskHfgLrKroOsCSXfDT6Pk0x
	mzg8uoJ7nJyoS9WyHnm0pIWgal0hIQQgidPJwQypEhaA=
X-Google-Smtp-Source: AGHT+IFqpXXFZHGJ2TR9L99ruHtcO+35YrS8cfBk8BbM42O7AY8tmrPTKw39ZOkfHlglXg2YAbosGg==
X-Received: by 2002:a05:651c:20cf:20b0:332:1398:5737 with SMTP id 38308e7fff4ca-335306e1b53mr2567991fa.24.1755590258074;
        Tue, 19 Aug 2025 00:57:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3340a473b7fsm20513871fa.27.2025.08.19.00.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:57:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:57:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] cpufreq: mediatek-hw: Add support for MT8196
Message-ID: <aKQubSEXH1TXQpnR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Nicolas Frattaroli,

Commit 32e0d669f3ac ("cpufreq: mediatek-hw: Add support for MT8196")
from Jul 16, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/cpufreq/mediatek-cpufreq-hw.c:76 mtk_cpufreq_hw_mt8196_init()
	warn: passing zero to 'PTR_ERR'

drivers/cpufreq/mediatek-cpufreq-hw.c
    72 static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
    73 {
    74         priv->fdvfs = devm_of_iomap(priv->dev, priv->dev->of_node, 0, NULL);
    75         if (IS_ERR_OR_NULL(priv->fdvfs))
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
devm_of_iomap() can't return NULL.

--> 76                 return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),

Passing a zero to to dev_err_probe() is a bug.  See my blog for more
details:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

    77                                      "failed to get fdvfs iomem\n");
    78 
    79         return 0;
    80 }

regards,
dan carpenter

