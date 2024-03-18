Return-Path: <linux-pm+bounces-5069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08D87F03D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 20:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B977228454B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0B5645C;
	Mon, 18 Mar 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcAnd+0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F495A7A9
	for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789123; cv=none; b=ovs7KBgItkxRRTrbQ5Rm15floDkLdG95UO5H07lXu7rGzZXB5QqlQp5K47FI5yIRYLsbfzuFtKQeu0+9R7lf2ewwSJ15tPrqQ+sVFaa7NQYfAZQgZBhhAY63sKbI+E4bnbuCVCTe6RYtaBdcZaDCQWO7EHyS9lAJJuLJDkRllgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789123; c=relaxed/simple;
	bh=cWgN5flx1Oo7Rf6DGEEMPqvGWt+1MdRet/Aw8HQNoXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6ZVgBwLlRt+s6ajyIXEr1FOGxsv61yZ8onr5qycDm+NcDSvvYUyD58cChJ2ju8YD4OX+WjRHI5eUSa8EdbpNDnS9z4BK7GAlVmll/VBRidwFJsxEBdDJ3QsuUKYaTFjrHWhhC3C0GWvmSt6J1x9W56TUsHASJVbdwqO6s6ABPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcAnd+0j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e73f67adcdso72201b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710789121; x=1711393921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6zSTYWz2t9M71wsYPN1Q7M4F9RTQJHk4ZLPSZfImos=;
        b=lcAnd+0jdzK4d1ZO1gzdXJ8h/8JMFh3YtrPqKXPrjwdhqeB0ssFTfdc3Rl9UI6RWhk
         xmsv+n12YJbwYRHeVy3jjzF9QVDyMA2N5xfxRSjxx71W3OAU07mnU1xcCo6K0C9CNCS8
         toKWh9IGjP2IPPqeBX4/nmGto1Y8DPAn6Dbymst//nzr/hZaPEOkPUZyuxDdyYe/2XRw
         4tG89qe45PjnZNHj8CVk1NCzyvwr6VhvpCPprwQvR+DzM/CyXQNCd+yxricveJGs13e6
         /tFN+YNgga8X46ehPl3V8wlkh3vUZS8hXdQUoejPPIxiiEBulTpBDrBnFIe7pICLbTnl
         WR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789121; x=1711393921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6zSTYWz2t9M71wsYPN1Q7M4F9RTQJHk4ZLPSZfImos=;
        b=cdtNgMg9iNNARRNIG4FcPS6On99wC84ovU6/NN5An0cMqrSgl3hpXeBd+UyFlWEVH4
         Y9sd3U3THB9wVNtbRPq8aCBqhZsZSBCYqDUAZOkZHhoDvRCzhlgc9oaFsdgfswqtod52
         vCBSZsvkCyrdI3dXt68/MDfQRupows0ugbrUPRIpnNfcMswBcJsR4KU9S0LTpcf483ph
         BXW2ibMSMtOhidDSNalfdsrsnFerc44AT6yUuxmE25CwIDsaCBL7grwNLNAe0uumKHxn
         MDlWQjNJ1S20UVMRafta3cmV2s4Zp5O2xghHmVoEkRePDp3sH4ct0reCtlU/Fj8pjq9B
         REwQ==
X-Gm-Message-State: AOJu0YzI/H9liHJse3Y/rGuZEIVJm9ZAu0WlJZ2/oe7D8yab1uQFUrT6
	4whEgQFRPwirfWGvCyQHsEdy4CGfM1GY2qUmKbmwibKRAThKedHy3eBxQo7N
X-Google-Smtp-Source: AGHT+IFgw9D02TeBDKYpFwwZCt+lNoSrPeriKW15dSD+sNrFasimvyKnVl7ZOhP3Ve2Eyoj8yA39VA==
X-Received: by 2002:a05:6a00:2d86:b0:6e7:3119:9cb5 with SMTP id fb6-20020a056a002d8600b006e731199cb5mr2524787pfb.2.1710789120479;
        Mon, 18 Mar 2024 12:12:00 -0700 (PDT)
Received: from davidm-laptop.gv.shawcable.net ([2604:3d08:1582:d200:257:cb41:7a1b:52ac])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7864e000000b006e566b4872asm8249635pfo.113.2024.03.18.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:12:00 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: linux-pm@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 0/1] Failure to hibernate on Dell Latitude 7430
Date: Mon, 18 Mar 2024 16:11:51 -0300
Message-ID: <20240318191153.6978-1-corngood@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a Dell Latitude 7430, and recently whenever I hibernate with
`systemctl hibernate`, the machine would immediately wake.

I bisected it to:

0c4cae1bc00d PM: hibernate: Avoid missing wakeup events during hibernation

However, the underlying problem seems to be that during hibernation, my
system gets a 0xcf (power button release) event, and the above change
causes it to abort hibernation correctly.

I also noticed that holding the power button down (when it's configured
to suspend) causes the system to suspend and then wake upon release, if
it's held long enough.

I'm attaching a patch which fixes the problem for me, by skipping the
wake on any of the release events.  These events are all marked
KEY_IGNORE, so think this is a reasonable thing to do.

I'm a little worried about the consequences of doing this
unconditionally in intel-hid.  Perhaps it should be a quirk?

David McFarland (1):
  platform/x86/intel/hid: Don't wake on 5-button releases

 drivers/platform/x86/intel/hid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.42.0


