Return-Path: <linux-pm+bounces-23858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49949A5CA53
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06517189667F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C02253AB;
	Tue, 11 Mar 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBAXtP3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948F25B68E
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709315; cv=none; b=fHfTcvKI7u/O0tmU6Za6vl8Q/lGKo+0yD4FXI/IARRnwwUWMWIXK1PECxDwgFZPPbCNYZEEmP8O4GKmd4TZHm8eQON6QtAQrntGiteYa5gxwBh18voTerw81BE2NafkTowT6oe9EijMLw1eeOZdC09p3qx3T4n0SjYahHDilfbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709315; c=relaxed/simple;
	bh=vvR37tHe7cyHVxHmE1PSmfJx0N0SOaT219U/VDaoufQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLn0iSckkm1XB8DXW7v+f8mLCu69y3mO8kN86xu0nWm6H1wy6ues87WQwA/RCcMSYbbJ9cwf3CWd6HFz/x5IJbYQ+ap6Rbjq0PreXpYdSze6htOY94y+/1ApgyvpG59UcUeXR1Ygtme6qmpZdr18pjG5XMJAqFw3taTux05aNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBAXtP3x; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bf8632052so43096311fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709312; x=1742314112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GV9BiiwCj0KjOF54Bg3Xs/+kHqJ8FRa+RX/vBXVgyfA=;
        b=uBAXtP3xVF4X0qYK/t7HpauVVlUPUx9eB4CNtKMjeW31AmE6gTCHJeTAv042yLGCcQ
         fVolKHnY6xYSf8DBlevb9vVhRaOpPVBpiDqyS8qQgiZpQLire7TvxW+6UaTka69pBoI3
         vA3oOI6E7jmyaiDQttfm9QFPobfsDYIlf41Ldm3TX4vTa0t/SnNksiuF8bMH7kJCsDAe
         zIMOLtm3dLZ9ke6VhMDmmPMJXOQLWtLFeI7u91zuXj3H3JKnogd4QpSPhchvSSkVr75A
         quQ2FxS8R5hv9I/JoZCZMM6T6ti+ZiEAa8zfYMeHwYu9p1aeE4BBvWaOXM/R7vYWh4Uu
         PnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709312; x=1742314112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV9BiiwCj0KjOF54Bg3Xs/+kHqJ8FRa+RX/vBXVgyfA=;
        b=K8y8/eHuo0d+VJUGcUQcw17xhJoleCudyTn6dR2VlrT7yuND97Rzom1hhYFlFH8Iqi
         RBOEvrE/jaPoDIn9+NyS4dT4CXKd/ntY0fIy2hk8X0SBs+yjY4ojy5K1iiUK8tBDBhi4
         im9O29T/vgCNCobxX3ZvDg9tsIAWOeLRZjDnPcfKd8jwoY9NOHF45/JTvSyCnKNUOGpo
         ZmI6u3HvMctd11Tvgtp9884h8ZBPPTVFGD+EAK5HtbFDMY3iO9UibDAwohlm/flRj2NO
         kvGV2catSYMPb0xEiHjBMX2c6C7r16i1QnTsusuGBxmRJVqLcSFGkuXNlkmrUZnG7blp
         eg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI1uPtZNeib+8J1eQF1sWANvgx28CCprLidwWsk5fiZRsdkgkDMGK/RhXy/HtK9FEEtjnCLXJe1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpL4tA0RzHXl4WbwjUheVVW0YelfI/742D5CaoPeyldWwzDyUF
	cw7volNzUkDnZ7pAwd5Jm0VL7W6cEYNQYSKYDBLnq19d9DvSmmbEVInNA5LHPa8=
X-Gm-Gg: ASbGncvp7E5K4UB8m9fmB+xYegMkQB1ne3qybSMAxfQpLjJShRVsA82mcDIOrKJB63m
	U5IqVPBaJi5u/WiTmCxJAlOWdPH3UHCUsNl3bqlfLNF8Y/GRBzUc4tALbZyEI2NzLG2oKuTH79N
	YEuUyoEAkNRNXMhw6ogwsr70Yawjl6/zK0fV22GOoSXWP7g7Ex9N8SdCxEzJpgi74n2J9k9BeyM
	u0hirND58Dcl0tMzzVnTYivzqDppFOJTBGClui0BSDD0KOri0z1r1kyTdREAa2vqQj9WG2q5mm4
	SaTtbCHR8SKE9Nks1Ouqsv9pQtZy1SLF9o18NRCiFV0eqWRTWAYpdl9rrLXTpgQK4vh8cGHnRqw
	R5ygd2jsRszwyk7hDD2g=
X-Google-Smtp-Source: AGHT+IHcDSRBowB0gIghFW6AqPZ/rRpdWPKOTwHZTyDRWmZvHuECIB/VUu27j6hMEwmcrwfl6a4OUw==
X-Received: by 2002:a2e:be13:0:b0:30b:9813:afe1 with SMTP id 38308e7fff4ca-30bf45ec43amr74624571fa.25.1741709311824;
        Tue, 11 Mar 2025 09:08:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PM: s2idle: A couple of minor lock-simplifications
Date: Tue, 11 Mar 2025 17:08:21 +0100
Message-ID: <20250311160827.1129643-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on s2idle a few things caught my attention when looking
closer in the code in the s2idle_enter(), in regards to locks. These two
patches tries to improve the situation a bit.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  PM: s2idle: Drop redundant locks when entering s2idle
  PM: s2idle: Extend comment in s2idle_enter()

 kernel/power/suspend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0


