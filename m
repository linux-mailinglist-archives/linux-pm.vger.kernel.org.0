Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003B014AE88
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 05:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1EAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 23:00:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37270 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA1EAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 23:00:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so6264974pga.4;
        Mon, 27 Jan 2020 20:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeb7c9R5os4FhU0ngzBICJpqeLgUbo3fqd+rMCyfI9k=;
        b=IW+3XxEtSxZB0jg2Zmo34BOWXi8x9EFk6y1X8o91SJHDfx9P+h4z02/iXKzyLfDV2G
         2PI2HZYgIbGSOKfoyhZwcKCldaOh2qK3GtvZBFGHyS5dhbCaMugiele3BcuUdhEccr8R
         9LO+7BfGF0BZLpdzTMstpR54lqLRDD4YMHOzXNcH/I62cRLV8ygRrUG1JRaYd6rmBgbU
         e+z503oSx2K4jKhPGcdtmMJO2Swxpm0xik/gjtyOexEb+hf4RAo1GFCHBzN6oTbw4hGc
         ztOf0ACL9lzYwsV8LX71FDr0EvfB18k7R2FYCt0JN6oQ0Q75/sukRYlhqESM1qFYY3EA
         7wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeb7c9R5os4FhU0ngzBICJpqeLgUbo3fqd+rMCyfI9k=;
        b=VpvufCaHa36JLIhcYDtF+d4LcXHOlE1XQBdO5jnirgT+3l7wPIfuTR/LDRp2VT8qLD
         aYBhw2pNgLPW4v3HTVShM2SZStezgT/IBJNHfm1dW7RD6pC3wKGcb1fCc9c0eYHyalY0
         rql+rBf1AJUeJTkWndg+CDqiYeKdnaKeh4Ddc7q8BH+Pf+jfbecc0svsFKuvz9kZa4G4
         o50D2dnrMybME3mGA87Lnhf4JArAHQ7Yy1U1QXDgw0VSYeZXGIrvnpyGKIuzjQHdYPM1
         +615nrNnOeXst4j9ebZf0M1tjYoxqTYicln5INBOxilS9JWq8Zdmlk8oGPWi0WZep3wW
         Og3Q==
X-Gm-Message-State: APjAAAUgEepZ8c4hfqiAFRHxDXP3CscSeWtdpZpkGX27Iz9M103YVTnT
        /IsjmnJoqflTihovoxYPMMw=
X-Google-Smtp-Source: APXvYqyofZu1ouR4g/MgaA/VG2UwbEgLz/RWa+yyqBaKFqeaEMLSelMHmWqxmxcgxGpum/I4Tts+Ew==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr24047658pgi.220.1580184016303;
        Mon, 27 Jan 2020 20:00:16 -0800 (PST)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id d22sm17464489pgg.52.2020.01.27.20.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 20:00:15 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     dsmythies@telus.net, srinivas.pandruvada@linux.intel.com,
        rjw@rjwysocki.net, len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] tools/power/x86/intel_pstate_tracer: changes for pyhton 3 and newer processors
Date:   Mon, 27 Jan 2020 19:59:55 -0800
Message-Id: <20200128035957.2577561-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some distributions are deleting python 3 support.
A backward compatible minor syntax change is needed for
use with python 3.

Processors have exceeded some of the fixed y-axis scale maximum values.
Change them to autoscale the y-axis.

Tested with python 2.7 and 3.7.

Doug Smythies (2):
  tools/power/x86/intel_pstate_tracer: changes for python 3
    compatibility
  tools/power/x86/intel_pstate_tracer: change several graphs to
    autoscale y-axis

 .../intel_pstate_tracer.py                    | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

-- 
2.24.0
