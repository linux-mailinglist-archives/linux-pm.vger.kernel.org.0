Return-Path: <linux-pm+bounces-839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30E80AB5E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 18:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709F51C2087D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12603B793;
	Fri,  8 Dec 2023 17:56:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68466B5;
	Fri,  8 Dec 2023 09:56:35 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb1620a00eso315828fac.1;
        Fri, 08 Dec 2023 09:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058194; x=1702662994;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUs9NAUW/uyNzOxhtPteADRhFupgpVxBkAhdaovCEhA=;
        b=dP5BmMnJl+jGdGSw7dyAH3ozyLyVJ2+dG3sYZaNmHGW4xL+F35lJYbAxrvbr7cAMTC
         vKQA8u+aKnkA5jdnHgu0HvByPDq2vHlfFUvZuZ3z9yUtyvg842SpdHIg3GD4O9V8mXAL
         LIirbLa/8poLuwHGyZRlEQdtHZVenfyui4jQkrrxbiI0R2kBsxrvpmRQ4D8Lpwg5Mi9G
         oKrDVe3/FsVPVLD54n7934ynVuCSRWMSP2lEKYTv5op2ICY9gZy+WWcZ/D4DLWqOW2ba
         71uRxKPMAwsfZjxzr9CJPJ0TtAHtg/K7dYJYx/MTXhTgMA5CslGCHDjk0Uuum8VujXqU
         Q75g==
X-Gm-Message-State: AOJu0YxOlJs5wqr6rnB2njGta0paDPB/EwjuE2IB0Vx97JO2lrNEWnTA
	kaymcCMZyyAGJSbr35da+1ToK2XCMECGsLuDkSw=
X-Google-Smtp-Source: AGHT+IF6+KCnozba4ihB7BzlABjrLTBBl3KUadkNG8wAN1Q8mkDy7SSfieoRi/6dT8SIGsXydIsxFZPrqQl8/l/1yHw=
X-Received: by 2002:a05:6870:214:b0:1ff:a3d:f750 with SMTP id
 j20-20020a056870021400b001ff0a3df750mr977107oad.5.1702058194670; Fri, 08 Dec
 2023 09:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Dec 2023 18:56:22 +0100
Message-ID: <CAJZ5v0guGojjx9qzhz_hNM0f2o4uevm2p7Pq3E=oUo+L1aVW5w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.7-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.7-rc5

with top-most commit bdefd9913bdd453991ef756b6f7176e8ad80d786

 powercap: DTPM: Fix missing cpufreq_cpu_put() calls

on top of commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a

 Linux 6.7-rc4

to receive a power management fix for 6.7-rc5.

This fixes cpufreq reference counting in the DTPM (dynamic thermal and
power management) power capping framework (Lukasz Luba).

Thanks!


---------------

Lukasz Luba (1):
      powercap: DTPM: Fix missing cpufreq_cpu_put() calls

---------------

 drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

