Return-Path: <linux-pm+bounces-38530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572FC83C76
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBFC44E2EC1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA946248F66;
	Tue, 25 Nov 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzMDC3uy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DE1D6AA
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056875; cv=none; b=INXTiiPQFk0qYVxX0tqpJ48kmL/1Gfp8Y2amt9WAe19ET6u7QBIL4LzT5Rz30x7EO//vrwIagW4bQEhe81DgZ9Dei5V/Sx3pccHfZOgOtIXo00H3/+QwQ0agtThzeXay0nOeTVUsXavbXJYAVe3iDHGc1o5h1u/xBsqwAzZoIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056875; c=relaxed/simple;
	bh=RIYW9f+wzQPaAN7MLWU8bHp7PfQfO0S7nfnl86inDf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bnM7Wu7rwOVO4poxGTcP9EDAfUHIjiRxbyNv/hX3ELXS2qGs9fDhSuc9eEfrMxNGvpWCcBUMIK6uVOBXxivsfSclQbeHfjZYVm2bSpE8pQOeIoR6UMNw5vqXMP+dnP92ROp8zngrS0IGcXpXhzrirqA/UuqyKluAvoy1yWyofaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzMDC3uy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8173642b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764056873; x=1764661673; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7icyLinbIj6S2jIsVgWAxNprsgfjFJ1khU1rBcgqEPg=;
        b=TzMDC3uyM6rYGHfDKjWKZalLtEwZpIfVPLKXrROuG8IizmzbGNPyeF7HpXM/golTzf
         /VW9i0m+9a2jtKSKyGz/X0H6OBkf6Wkm+cQRhGqK/L+8spp4umTfwT1eSRu6iVBo1fcU
         VvjYWR59/9RibcyLJlDslxUkb7n4euTTwtc2FjhJ+77xsNXrJZbQ9O/VB60UX6WQcMxg
         LYAEYp0xF8kpHOPBK1J7vCzis2Ipahrf0yLemO+yANcBh3g7g8QdSxJUPi/50Yyj5fLE
         xmhYCx7GspSJ4+e75Ns4JXB6MAhpzvgmCrLA8Lm5e5vu4k8OowN8KgbAxr3mBaDwxCky
         9J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764056873; x=1764661673;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7icyLinbIj6S2jIsVgWAxNprsgfjFJ1khU1rBcgqEPg=;
        b=aWRMN3XvF3UQQCmvjKUuLsuKg/OBYuy/Mumb59eB4XgpwqRBWJBOcKJMBeGGq+ASiz
         6qMPOkujIem2RSI7sWp1KerK2LUgSNFRUyfo0c1vu1BF+xusi7PViztVd8DJ/tlh2be6
         0Ac5Np3fVoQTdkQvJIQx1aqvRaviuKsThDCw66hS8LesMXNZGU7L2289Fu9VAoKbhl6p
         ZToHLDh89CVN35lqFbmia3+Fjl7FPs/h4sCFVWb2q0Z1KvKfVRf9fay+G2lRzC1NCq1m
         T8qM1zN+7aMcTVGobWRS1/XLO6KNvjjmkcKNArlfYiW5b9zoZtX9dX9GqW11DLr239p/
         fshg==
X-Gm-Message-State: AOJu0Yw3U5/IzMLOwv/cwA5pdKL1sDDdeXEIyHYdOKM/XfzXvwqYM5r0
	2OxU1B1Dp6p+BPhO/SrfnqjrBvAt4+d8RP7kORpvib3bG4816ojpxEdzqD6XDvt73BBVQZJXlwo
	9W/Jq
X-Gm-Gg: ASbGncvw1EOGJzCxOucqmONW2d6YMqVylToNsoFSnVjXLrolbMIeEP6eUWEBY0P7CdB
	cGp9K9WHVCuW+yVuMzDm6qNmpRtVkSBkL6a3iySrQyvC7EyAg+gsesfVH255EiGWxMw/GAVXSLm
	7eYgmVJpihOcTgWbdGapThCJ170GDRs4W6/ZSmluUa6wsEeHOjoRoluVgixXL5CPw8fgpDsmwM2
	8lmWddOQXImdAZqk2JuO3K6sXf4G5Cjoi6EDA25O6tuuFeykN3SbtaDzW+hFRf6ppfrnjm66ObY
	WjWpBMPOn95HTryHmKsX9GBcF16vhNiW2SGKTTIfFgotP60IOw2pYv/9f22NdVXfDZe480rPAEo
	4eCOS+rTJY8IMTLZCGFtoj4yPS1JP9sWiO+5styUXxpBxPrAxYJKaprP63izek3M27MwDWmq5QN
	5ztOT0ulsMEPw=
X-Google-Smtp-Source: AGHT+IGfyd+ebU1bMdYT1r81FU/xJ7fVe6a2Z/IwJoGczOXL6VQFsoZD5SPqFF9jXPvj/h8WGY3Dmw==
X-Received: by 2002:a05:6a20:5493:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-3637db26015mr2087940637.8.1764056873406;
        Mon, 24 Nov 2025 23:47:53 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7610a6f80sm15270384a12.32.2025.11.24.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:47:52 -0800 (PST)
Date: Tue, 25 Nov 2025 13:17:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.19
Message-ID: <gypfpu4vlircby4x7oyaydeihzmcnuifym6qeui7w33qh3jbke@ekpc5xijbdvl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.19

for you to fetch changes up to 33ffb0aa8ce8b18aaa65e0f9346d52b4e314ad7d:

  rust: opp: simplify callers of `to_c_str_array` (2025-10-23 20:51:17 +0530)

----------------------------------------------------------------
OPP updates for 6.19

- Minor improvements to the Rust interface (Tamir Duberstein).

- Fixes to scope-based pointers (Viresh Kumar).

----------------------------------------------------------------
Tamir Duberstein (2):
      rust: opp: fix broken rustdoc link
      rust: opp: simplify callers of `to_c_str_array`

Viresh Kumar (1):
      OPP: Initialize scope-based pointers inline

 drivers/opp/core.c |  69 ++++++++++++++++++++++++++++++++++++++-------------------------------
 drivers/opp/cpu.c  |  16 +++++++++-------
 drivers/opp/of.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 rust/kernel/opp.rs | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 4 files changed, 176 insertions(+), 148 deletions(-)

-- 
viresh

