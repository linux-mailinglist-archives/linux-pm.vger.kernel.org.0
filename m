Return-Path: <linux-pm+bounces-19591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACB9F9B37
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D5C167547
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750302206B5;
	Fri, 20 Dec 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0Uat4gP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35C157A48;
	Fri, 20 Dec 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727664; cv=none; b=NUjsk0+O9eB1N2tE2umezzHdGUSIzRImCc4CIhcIddIzcDHmFoaM0N0mShPlWzaYW/dUe6cIVhLam4nKscUHNyGzCveYpR8c7PIMmezPsZ3hTbyPHGjUpNVw9GoPm5dkbDKfjU+9ToiRKjCjmGHelhDnyOlkexOLk/1fx+VBdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727664; c=relaxed/simple;
	bh=s6t+af5ZrXcvOmVwOmdE/MvKnEj7rz6x3uDF9WwrOZM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dqZaD4g5r9Qy1dq4iDZFBMl3L0da6H4RbrB+r3Xm6yR099EZp5spz9x4EGHAWEcSCkaqC3sQdKhNtqvwtjoYuV+pD+X+gNITHcU0wEcbyCA3iXR8aFhSdt1N1WQ46BnqjTw7evroxjjEBmm6QNHA6n5gW62Bf5SlaUm3rsfehmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0Uat4gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C627BC4CEDC;
	Fri, 20 Dec 2024 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734727663;
	bh=s6t+af5ZrXcvOmVwOmdE/MvKnEj7rz6x3uDF9WwrOZM=;
	h=From:Date:Subject:To:Cc:From;
	b=Y0Uat4gPaGlaLd+BQIxH2SgcgaSombMofaF4mZ5ciVra6ZlQQ6LEXALuRFMNLdmQm
	 Y79BNZyp7AHa6Ac4ybD//xkej6+abGXEo1RDW6rtEiLlfj58tAT3Rx2IKrDirSqbpq
	 YsiGNYSr9G1ZX4Xjsul0Pbx/NomCHzmUDSbJctFC0cmjC0j86RU+VZh19D+M1lxRxl
	 gSO/MjNUCJ4ynOB59vwoKpCVYZ0QxWVFTkIDrbhgXXeteYnHTY5BJs4kAIs9ycu9kR
	 31CdCt2rfMHdLYrtua/mwIYMMoxJ94F72glhBs63Jd8oAM9G5T1UpbiQA8rN4CY4Hl
	 L4SXz3GpRrSaQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9a0a2089so1261293b6e.1;
        Fri, 20 Dec 2024 12:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXauVNlJguq1wwis4NWT/zXZ1wLv5WGJXCBmV5EDUwp8wIsIpQLmFF0gn+lQosv1S7D9NrSvk7hzWWt5Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjd+XPUDyJXr1Oo7QcBWVpoSXmLZAWaX1gyyjGDCw6plFdsrx7
	remLJVNEAgQrMZgWycH6I8HlMAxldtsyTcBG39DAwZx1YOoQLC8o7ll4ue0LZZKpH325qK9/1h3
	f1K8nZ1oPxTIIwdHoQz6BNhuepBA=
X-Google-Smtp-Source: AGHT+IE+4sZtyg7bqSoKkc3DFkJutDrZpjSxr9jYpKabHKUrqpkGDxinoS4a5Plggax0GQ9+vF0j8hJhjzCNMmYh0M4=
X-Received: by 2002:a05:6808:2e86:b0:3eb:53f2:17d4 with SMTP id
 5614622812f47-3ed88f89505mr2119159b6e.25.1734727663143; Fri, 20 Dec 2024
 12:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Dec 2024 21:47:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2kY7UQKcZVCE19mKKfL1muw+Qnj_Wq4GBwtuFmvgMxg@mail.gmail.com>
Message-ID: <CAJZ5v0g2kY7UQKcZVCE19mKKfL1muw+Qnj_Wq4GBwtuFmvgMxg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.13-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.13-rc4

with top-most commit 4feaedf7d243f1a9af36dfb2711a5641fe3559dc

 thermal/thresholds: Fix boundaries and detection routine

on top of commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8

 Linux 6.13-rc3

to receive thermal control fixes for 6.13-rc4.

These fix two issues with the user thermal thresholds feature introduced
in this development cycle (Daniel Lezcano).

Thanks!


---------------

Daniel Lezcano (2):
      thermal/thresholds: Fix uapi header macros leading to a compilation error
      thermal/thresholds: Fix boundaries and detection routine

---------------

 drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++++++-----------------
 include/uapi/linux/thermal.h         |  4 +--
 2 files changed, 38 insertions(+), 34 deletions(-)

