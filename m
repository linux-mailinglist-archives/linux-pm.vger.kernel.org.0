Return-Path: <linux-pm+bounces-17687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967EB9D0871
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 05:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C36281B4D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2156A8D2;
	Mon, 18 Nov 2024 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVIzdsof"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BF10E0
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904633; cv=none; b=I8/v7ji5o3h+VpbNL0kevJyD+yKQzLKKiB9+SgGZvDUDt34JkUShoXDAWnJ2ZwEip51KZK0rdyPj1mes4/iBXZ/fPbwW1aEddYX10CTevJIhe/B5dg/L++tD7yOCchWZTg0Oq8qQ55fMc7aHZTU4i0ra3Vh2qUE0tr9qgMRTntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904633; c=relaxed/simple;
	bh=ipWzMcYsmExmp6Cb24PX2a7/swbbvnvtHsLC4tJRCs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YllU8gMFr80m2/pQb1VzAIYtyU11XouqKhpDMxGZfMvbDpkpOKvWnLT1pFyXW13Dqyn1oT3IuRjXvR6AnPzG3Rz7D8CgDsTTTHKnd9IHMRcmgmZJeTQ1FLprGNMihnP6CMF+gGXNZ4im8Fzlk1c9CJo8r20TajDIlKnrcvOFF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVIzdsof; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so889696a91.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2024 20:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731904631; x=1732509431; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiZd0icOdBMLtEBzPPLyeh7ODHRIiPKLv7k0pCov9Gc=;
        b=tVIzdsofJ7sYT/m3zsrIZrusI5a86CUf9R6Xq1DDNx5dpbrmhA2OM+3d4vWHVxhhtK
         g91n3hvlHglCw1ZNWxRIK/PL6w/CuHkyhsn6lM+Z+GS0/fNNegUqo1co2gyoCn4W5M2C
         NnEAD7luz6kj0PfUJGj0xjng24TUHN7Hnn8y2La09k3jE0Spf3E5vKieyGRTAhdHM/cG
         dUpCsZ79/IecF+a/Vkn5MPo8B9o6OJdet8Qv8qNBo0wprgDbwY7iXRdwV4NAWuq/sO1H
         rULE40mwehaObcY+oYCDeSoHj8V8FZqH1UNgVgrAA8Coon6tsrTGVF33xumjkRyCUQxx
         59QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731904631; x=1732509431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiZd0icOdBMLtEBzPPLyeh7ODHRIiPKLv7k0pCov9Gc=;
        b=bznky2OEZM+ozThYUF5es5/ow8tmzqKrgCeWZY8L0FsWz1uO0tMet7xtmcFUBv5zCa
         dAGby6nqgyURjS6GgMduXqZoUBQLE7NSGGsOMH7txYUq0MFeNfzov36acd45IXhNZF7+
         KwAF107U3tPno9NeTtMJXehSW55uDIL+Jf0VLGL/aXbOxRqJpx4nQ6Y+cH+VXznRqgyK
         MMbyM6Vl4DmXCXZVUdUg7y1rtziVi5Iaw1EqE1f/ZT3QjIIQJPAf8bQG2UwcobH8kwsl
         yGRmpjMB9AIL1gfRX5o/gHpnRZJfRRxcjbpifNmR3aoLXw1TqhfYt3Tqw7BzKKFjbblD
         z+ag==
X-Gm-Message-State: AOJu0YzraEcZwLP7TP9/3ZWBXBb5Xji+szYIbFr0SSe3dAHdtXN/pK6E
	pamP+8sO2IsqYREuO+UbGkRd/0a/SHw52QmioUuSYfjYgsnD3nN40n7k2nDNQV8=
X-Google-Smtp-Source: AGHT+IHOgsZfia14NTfAzjo0NSG1Z5Jj4e6vzMMpHmqPTgsj1zZIHtV9Rl1rb8HVGAPsM7GrDSlV0Q==
X-Received: by 2002:a17:90b:35ca:b0:2ea:5083:6b6f with SMTP id 98e67ed59e1d1-2ea50836cc4mr5302540a91.22.1731904631451;
        Sun, 17 Nov 2024 20:37:11 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1b1aasm6448293a91.17.2024.11.17.20.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:37:10 -0800 (PST)
Date: Mon, 18 Nov 2024 10:07:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.13
Message-ID: <20241118043707.zxyo5wl765dxypkm@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.13

for you to fetch changes up to 53205a7903666d35709954d9fb7370a8150d5e0e:

  dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw (2024-10-01 14:57:08 +0530)

----------------------------------------------------------------
OPP Updates for 6.13

- Describe opp-supported-hw property for ti-cpu (Dhruva Gole).

- Remove unused declarations in header file (Zhang Zekun).

----------------------------------------------------------------
Dhruva Gole (1):
      dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw

Zhang Zekun (1):
      OPP: Remove unused declarations in header file

 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | 20 +++++++++++++++++++-
 drivers/opp/opp.h                                                     |  2 --
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
viresh

