Return-Path: <linux-pm+bounces-23914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C824A5DC72
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD641771CF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415881DE4CD;
	Wed, 12 Mar 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFmiRQ3d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94824236426;
	Wed, 12 Mar 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781883; cv=none; b=DMZENlbiJCqsQTwXF7zwVJLTApqJaStE3q4lTYe/VXbnFnAO8jS7yOyWWC9nXD2wB3Ali8qwM+wFnYTBOQ31gMPYqTj5uCkRn+GnQWVXg6uFTsUDI0AO9XOlJHO72ybO2gUqIcti+EWgH90tTpMxPH5VqoXKmeif6poyzgiIkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781883; c=relaxed/simple;
	bh=HAmmIzEk4qiS0Ha9xMIkcmD5tZckjPN1p3IzuIL22lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhJ3GCTgG7RvMTHAREu/aCZGHgBnGL7M3CF3g/5NJesuVn1hqwskEcTycSKAqf9XTmTXDtYrTNKKpJWQ0BLoM8et3hrC89jY4PqNHOUVysx/1JojsCKl6HqgC96Pjf/la5HsdUXnkvAkbm3lek0r+MIKtDyFk5nicQeQLyG+NCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFmiRQ3d; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso1299375166b.2;
        Wed, 12 Mar 2025 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781880; x=1742386680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAmmIzEk4qiS0Ha9xMIkcmD5tZckjPN1p3IzuIL22lA=;
        b=QFmiRQ3dVHsB8wGeEejA1Th33RCNFlAIXVXj4t1maDEpwQ+pr+gusi7urDrYz3Qu9S
         OszHDXFghS/PVez8HEv+CmjF8RifHYuz4EyZM6fj7vJvjoSNJMNl1R1eh2yI3dFBFn1Y
         XPbAz9GETHPACnpfHImJ/MHYclpQtz8dw6kRoWDkY6zs/8Q5sICfdK3sMqab5WxS941w
         4Suoe+WGRpMCPu3MB0CfRWMF3r3PBkxm0XI16LjjuRi+ErPlFZ7Xj5x+7RRY8DNDRuVc
         mJY3kC1kRDAjeTusvpDu2b63YKRYiuO448J4uO509Hqv9wldR+IqaPvTQQCbZ++AtliY
         2YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781880; x=1742386680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAmmIzEk4qiS0Ha9xMIkcmD5tZckjPN1p3IzuIL22lA=;
        b=DIoVub7ew9PDiqqgt+c4csZjMP69xL+V4RP1ETssdTMa7bhZfoMG41KyAvhPipc0j6
         Hf102Y0E4bJnT+WUUxLyOYkYNWT9q1qygdOqBx47DDhfYKQjv/bcog/mFq812lDeQBFC
         7RRVTxt1IBxxidmSHrq3d3cozBNz8nQexxvVS/IopD/YrQ7uukVL9G2sTvzM9pKr1YvF
         JutWtQt4B5SSkEi6aTb+nAOuJZNkiXbwiWVJjysejqbuHeC2H15NJMS8g8jqmGynwKxp
         r28ciJpspZyAvb80fLUmVrIFWKCpSFvNskG0RNcyybgj1qnSfvBUVWRj4njKJZ4pUwkc
         zigg==
X-Forwarded-Encrypted: i=1; AJvYcCVdbRZV4qBgEHUx1grVv3shct1cBWpIiQWTZHL7eT/m+BGzTZCwBNTzKIAUJpCCmQp8N9Hfttf01NniBCg=@vger.kernel.org, AJvYcCWEisMReGc72deE4jPD/BSdnNjK8yMshwt7aWqeiZYFmuc3S+siQB/oo7qb62CBnUez6LMMRLXvaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QAlLgM8AxHcZ1VPxaHsfOXLfX9BnWn9eDt6c+Rdhx7NjS80O
	39nAgYd2a4TfZukWN6mInbJSYcmmH+VWoTNJYvB8aAXEBD2IqlWNU6fCpLub
X-Gm-Gg: ASbGncssVwQ3Y/PLxte53QuhfDDy+33uv42b5WNcnJX2tpcwMhjwapNrNvACuF9qWZc
	uw2OkKskDD19s4aqLM1RrqnCCr6loNFcEtTMOCMpLBI1vU7Ml3dtn5uZF37mdcle7gRpWI6jId2
	8VFBA/e6G2SeAnV6Lh0dDNbzETZLWz6jHjvI+diwMyeXrb+b0HrUxEazXz+teXg6Dl6k3I91PFf
	4xnwv6qX1dFzOUgw07BOW0kEzKMTitzTfKUwtY8LlAovvEhO8ImIy7IozjPhe6qlFFCkbvaCZpZ
	Piv5EUR4bfP9XD3VhDaQ68yjQlhAizE2Dhrl+mj3TrC2
X-Google-Smtp-Source: AGHT+IFfshNjX+VzbI/wy1G1s4a9ftjRnWREdP8/Qsh3tGzC5CDmK0L2EO8vnrxxCffMAZyC2Zk3sg==
X-Received: by 2002:a17:907:7255:b0:abf:52e1:2615 with SMTP id a640c23a62f3a-ac25274a004mr2594510366b.7.1741781879598;
        Wed, 12 Mar 2025 05:17:59 -0700 (PDT)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28847a0a8sm623586166b.119.2025.03.12.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:17:59 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>,
	pali@kernel.org,
	maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	akemnade@kernel.org
Subject: [PATCH 0/2] power: supply: bq27xxx: do not report incorrect zero values
Date: Wed, 12 Mar 2025 14:14:07 +0200
Message-ID: <20250312121712.146109-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bq27xxx variants are unable to automatically determine the state of
the battery, e.g. capacity, after a reset. Under these conditions, they
will report incorrect zero values even when the battery is full. This is
misleading to userspace, and leads to premature shutdowns.

In an effort to fix this, a patch [0] was submitted, which unfortunately
introduced a regression [1]. This patch series resolves the regression
and implements the fix correctly.

[0] https://lore.kernel.org/linux-pm/20250207220605.106768-1-absicsz@gmail.com/
[1] https://lore.kernel.org/linux-pm/CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com/

