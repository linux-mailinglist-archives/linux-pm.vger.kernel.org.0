Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3B10FFA3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 15:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLCOLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 09:11:11 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:33240 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 09:11:11 -0500
Received: by mail-vs1-f41.google.com with SMTP id n27so2443493vsa.0;
        Tue, 03 Dec 2019 06:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qTLUegBYXPVqSzZ8JeB8YIYZDh+eRGVTe3arH73i1Hg=;
        b=Xhbiy6OrTTxt/hCViobblDgaFs+4gw6bycEwq6/tOkvF+lgRF1BEfGAPoBLnE7U/Y2
         +gnLcX6Fsc7SluFFge3jvj0bVQK8yLgUVufH7ts+yhYtu0hA6mwAFDMt8J+Wq9QWMFg+
         VIDiIHVthFhl2knwEHl3jcjUH2Q9uYR+XN7n+EZ6H6C1QVOnEA0ga5y3wK88fvh70mcR
         J+DO/5idC+hegm6yXRVzck6gaXYA2TxnTK7Pf4I3PSkOPGZEyxlS2Jillh1MvfAelNjJ
         0MPhjq9G8i6f5VNBtuaokQ85rXoq4ykd3IQ9qUHUGKUKJW4IDp4dM4zzLz5FcVlGDgZp
         QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qTLUegBYXPVqSzZ8JeB8YIYZDh+eRGVTe3arH73i1Hg=;
        b=VQsI9VTjSCeXWvgAMpdbxVaHLtpW6q4CW/LnvePqEkYxkBZNqMWN0KuZ78vrTHgnLV
         LcoRiSLsUpTF/fMc0bpzv/ZIQQygoBkDxCLPPDNb5nQamG+TsMzPFviqcxPztht/0H6m
         i4Jnhg7Y8yZ9+tG978/54lGoeZWoGdyEA2ReV2M0aI3LB5bAo5+5ywJH2E2jY86cT4Tx
         DbkkplTxzF4yNjlFcC0n3AFtwCOi6+kJ9BON2E4akaYBvIz5HbKcjiTng9K199xKBtYN
         IUPrrixQKJoFfLKWpBVw7UA9x4sMFw89X1XAoBP9WkRFTICEnvLRQswf6PbNBkXtnV64
         2OQw==
X-Gm-Message-State: APjAAAXdeQO2W5D7ZYBiPMJa18j6wuq0iSi2EspUXmUuUy4PidDtWrJD
        HevqisTGu1SEUzdeumh6zDkJXkW6FhkjDtQcZ4o=
X-Google-Smtp-Source: APXvYqzqHb2yKwVKshU3kZPfBLtKyqntzMHOciBiiSeYXfaYezKwTIVEeE+9Ppgk5FV95Idtp2s3vmJRbeEykzJduPA=
X-Received: by 2002:a67:fa52:: with SMTP id j18mr2734055vsq.144.1575382270104;
 Tue, 03 Dec 2019 06:11:10 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 3 Dec 2019 19:40:59 +0530
Message-ID: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
Subject: interrupt handler not getting called after resume
To:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I have one general query.

If an interrupt handler is NOT getting called (for one device) after
the system resume (from snapshot image), then what could be the issue?
Note:
* The suspend worked perfectly fine.
* The runtime suspend/resume of the system is also working fine.

If anybody have experienced this situation and fixed it, please let us know.
It will be a great input for further debugging.

Regards,
Pintu
