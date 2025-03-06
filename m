Return-Path: <linux-pm+bounces-23559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A04A549BF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324EA189A418
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F98211497;
	Thu,  6 Mar 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWTDk3TK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F921128A
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260959; cv=none; b=aYCiodfAkG2+r+/xGKbCbGFEQqhi7zOE6U75/85/nt0j8V9xquGWTRwqBO5txrAJAvmSmXy9o1FtXe6HELCWNIjvTXZnJZZHZtbMlZsu7QoyeimKuQTWmPdcKyB8h6cF/Ja6s7QeuW/vN+AQrsV2+I630p3pRDo+S/lgsK9bN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260959; c=relaxed/simple;
	bh=wE0XHXR6nqEKsVcSdvuh0LfsQm3Tu2aGta4ii19Feok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUu5opMxiwFzRifprWpYthBrpYzvJ+TkTy8l9i6IXn+svdsOGihwWPmdAKzyCxbVCl31IlvapC91TfqYcJjLQJwfzgIlZBI0d6rRbRBFNPv+0qXmhCPnxHkEkuzwOv8u2tUGQ3JY5B3Br9IukguX1trFRPk0AE++DqPsOMPC05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xWTDk3TK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30b83290b7bso6464711fa.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260956; x=1741865756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koqRd4APX0wnsxAaTRkwWjS/3ijbfY8HBfEo6EAo4wU=;
        b=xWTDk3TKz3GnHtcy080IguR1Eb/ygXROmKK5J8g2WYtTk4Onukr+ZtxNfEMXN8a8LD
         PbJI25KWCSwDJWJZUut7f13If0afa7I+bEv5e4dM6J4l/7pHVj0eSUb0DEicdIiiUMFZ
         MSZoEyK7bXtl/JSgPqKqAeNKaFcDb/JATe1REqOlIh+I/LVzuSUuZ8gaUDp2LoN30tF5
         CZbIXos3IbHR9RB/4xW2Y1MfhTZGHr5RvJjPIhK3I70CDSk220qcnbHUGPH+LokMFs20
         DfCgfYq9DzHn7+VHSMxgxj7yr/bQ9oWf4FtsCggN+6tWToTyZUUlmgaYR9iRdI3MUp7G
         mtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260956; x=1741865756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koqRd4APX0wnsxAaTRkwWjS/3ijbfY8HBfEo6EAo4wU=;
        b=Pjdlo6HE6hKnodzUqFbUXGqK1OQ7dZ9ZOsKkjDoDOZUy00TcQcYDjvq4QBVm0r1sBC
         Ha5WY56E4IVPHJrBca4n9Ao01CwwR31xsvuKGOi0Xd3nGfz5/8wm4VdPfGbN8tHoq9fB
         oFOvQ/nxWrYW+lgOyyA5Jr6nN9RlQhSXw8HzZFG0ZxDcNnsWB/jptO6R2ME37WDCcZrX
         Do5fCR3Ww9e/szPGAOCOOsf4unerFjsxU/sQ23W8YaGXAHogiFMVms7hY4JPiaizbuiu
         mWeJnnjOMDjgvfuic9xDLZu6bF0VVDvtbPdlC9YReKhXMXSDrJIDQTCMVRg+EMk3oGor
         +fYw==
X-Forwarded-Encrypted: i=1; AJvYcCX+kP/tZhBE8okrUokFjCzytgjvP3OKdihsr4ZM68Ub923k1Eo7+cAWuwDoS0uslCLWbuFIzPb7Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSXVrx/wMXpoAIk40a4Dv0oQ39kQH2uubwLW8zRML0B2FV3qb
	Mh755SkI4DIUO6fAsleO9o1vVrbMofgcJHqXz7gFFDQFNZDmB1ipCt4HMen9S+g=
X-Gm-Gg: ASbGncvF8rN159KvqFREns/wcKrtyFW85HUnp5+8iRAXWBM6JX8Jqavrxupuc3GNADb
	4G+n4WyrgqFC2QBH+smeGTDuaF4RpV6P71WGLWwAMpwtTx9y13+vNRQ4WoTBmYoQDQgnIaAkdYJ
	NWbc51rJn07YccbjVv+TPIWtqu6i6a+cXp3pe8ips8pvzk+qJGanfbOZIIGWiZxy8JPh7TwOKHo
	7NL7iEYSecmuEUUPbanqoZKnSiy5DoWzJudf757uXcRO51CIwfie4NN6srJeExSJBffwjPOfxl8
	tMCsXTedNFIwTupx2j6lA1dRgP9UWtNnuXpTcRA57cx1dQ+KfE6PSaX7NEbxCiwJgh9znlguMa1
	xBc21CqWGbF6Eldc/8aA=
X-Google-Smtp-Source: AGHT+IGvhVCvrTJYtOe0f5Z+wlP8TVv9YwPwB9pxjrMJLEmfXqGPhLQZUmk5FXV48QUWuIm1wY6nnw==
X-Received: by 2002:a2e:964d:0:b0:30b:d656:1485 with SMTP id 38308e7fff4ca-30bd7b1c8abmr21290181fa.32.1741260955997;
        Thu, 06 Mar 2025 03:35:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918086sm1809511fa.54.2025.03.06.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:35:55 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PM: s2idle: A couple of minor lock-simplifications
Date: Thu,  6 Mar 2025 12:35:39 +0100
Message-ID: <20250306113549.796524-1-ulf.hansson@linaro.org>
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
  PM: s2idle: Avoid holding the s2idle_lock when calling
    pm_wakeup_pending()

 kernel/power/suspend.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.43.0


