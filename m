Return-Path: <linux-pm+bounces-36039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCDBD7FAB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A6A18A33DA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862271A294;
	Tue, 14 Oct 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NksN+hxK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616322AE65
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427831; cv=none; b=M4tYybuH9WuJRG3uKYKwGq99ORoCpUwI7yU/SSfAzcNN61S2zznT+LLS7/YmPNIak1/xlFY8+OZxGr8db539H6zz3zWfnaHCbU5DPRU1Y0pVhywJQTzMkLWgh+OSWEkbW72IEse+6wgXkQJMzO00dajVticpcZEDHWK4VYo9C1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427831; c=relaxed/simple;
	bh=5XIOTuXhcfgvMyryjkrWnOKtBwIw5u4qV0qabQznBgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOhN4GhVGSe1dxWf3mqrKMLt57aEsLAFC0aA1TDGIwfBUFPaZfo/tIhiSg0lzKjS7FqoWUzz3QTesWX5TUekGRNDKHJnBa4pk1ynlJ+F9Q/lQO4xCBSYmwNKXNU/fu3giD5UAE0sHy0zM9+q6SSsAQelgnBcMC4iDMRn2bTnmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NksN+hxK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3168494a12.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760427829; x=1761032629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=NksN+hxKLeRHLLpxmy7kf/1BCi1nudO+y+Chk7V8qgehN8PwHKRjbPvsBxHpGnb2Hl
         yiorbUOgyGHRcLzxQukCkUlvFDrHW51kFxySNmpJ803W6JNWGY504dmB2AIo++eqFucm
         QvU8d5ISe15jsZf8kCnR8d/vgwsscCWSGzgKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427829; x=1761032629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=eFPPlIkSgdcfCCD6318loEw6SLXCnK3lNwbFukE+944xqto4pJPYRn8nCAOJGsLtP0
         CdSvFfpBQx0OgjQ4kodzVn/cKFIl8NDKK1BU2kFjvXdoK4y1SJyMK/7fMjVk4WUpbLt6
         rLwo9RMqhLvPTgSAyHTBNO+2fBasSrhkQ6NDKsM82Z1H7jwN/k0KpiC8CcBqKaLwtyI9
         PnZZr09H7Jqx46sy62hqDpu0rxXRZAtBOsXhzwQWc2wq1udD6/4uy31yIp5lJuq04vyk
         tGt/UNUxFjarrQbGNgatBoFZrTCz2ShWNeMaOPepRSubnnzgLu4IVB0fldezK/87rVyH
         kdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1zSgC8XCrQFi4PMiPS4HK+b9ZaISvvpgVu3nJXAZMbEQsW8iqwodg68cRDV50w+3DhUEB06txJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4p4rFWefq8tlLtpGSvcIG6e+TkPTj6OrWhpUljhPbiIV82tNJ
	lfjMa/KyV3kdfj+NsWcQtXkkRvsFs9Kz/cZMzkyG3wVbSya2bd4DruTa1DsFs251KQ==
X-Gm-Gg: ASbGncsnEzTFYYQgZN7URaLh+BaWsQUAKsZ26VU24c5PyWb/hLWJHY+zu+9HIh1FARG
	SugOwuCjRkhOM873ZnDYgvub3ikN2O2QL4eQ6IfCdfmrlxfU84ceaorNey9NcgTwH6Z+FxmB/pC
	FBYmjuOLi3jmm6bSmElT8BKijCa/I9JNpiqgN2ekXPliAyioBKTARqNMwCs8VBrK4btzo1M3PPi
	mGee/mntG4i4tYJfJgIuaoDPERjxu14W0oKkV4tgpw9KjjXUOWK7tHz8xEnLR0QpPoQ82y6FZX5
	sv/re9V6fyMcEuBOHHZXRBHRvXQUW6IUCjKMHaM/GOD3o1WHMKFWemBmP8pc1exksJflbkB3X9S
	DmvvZPUUGtJU5JLvIZQu6dWaT8ZurwEmea7AnLHRNdXgqWfYRGZ0BkA==
X-Google-Smtp-Source: AGHT+IE0JPbH8RFvmKwtEh2tQIpvat5nn43ulCK2cRbdX4/desLZYKw49GjSVt+mBH4CgFZZKXWYLg==
X-Received: by 2002:a05:6a20:3d94:b0:2ee:4037:1df7 with SMTP id adf61e73a8af0-32da80b7fccmr27471304637.7.1760427829259;
        Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67af9dbf32sm7952404a12.21.2025.10.14.00.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:43:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:43:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	stable@vger.kernel.org
Subject: stable: commit "cpuidle: menu: Avoid discarding useful information"
 causes regressions
Message-ID: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are observing performance regressions (cpu usage, power
consumption, dropped frames in video playback test, etc.)
after updating to recent stable kernels.  We tracked it down
to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
upstream commit 85975daeaa4).

Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
invalid recent intervals data") doesn't address the problems we are
observing.  Revert seems to be bringing performance metrics back to
pre-regression levels.

