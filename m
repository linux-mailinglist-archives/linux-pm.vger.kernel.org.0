Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41D160531
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2020 19:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgBPSGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Feb 2020 13:06:17 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:57260 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgBPSGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 16 Feb 2020 13:06:17 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2020 13:06:16 EST
Received: from [192.168.1.106] (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7B523251A6;
        Sun, 16 Feb 2020 18:57:32 +0100 (CET)
Date:   Sun, 16 Feb 2020 18:57:26 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: smb347: issues with  IRQSTAT_D
To:     john.stultz@linaro.org, ramakrishna.pallala@intel.com,
        simhavcs@gmail.com, anton.vorontsov@linaro.org,
        mika.westerberg@linux.intel.com
Cc:     linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Message-Id: <1581875846.314698.0@ixit.cz>
X-Mailer: geary/3.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

after wiring smb347-charge into our DTS, I noticed issues with Safety 
Timer Expiration[1].
This functionality was added with commit 
1502cfe19bac2f8490e4167f2b7cb50b9759b273.
I suppose that it worked originally for Ramakrishna.
I did also notice, that SMB345 patch omits functionality with IF.
Since it fails for me even on SMB347 I guess there could be possible 
that:

- this funtionality is available only on some specific chips?
- something must be configured (in HW or SW) differently to use it?
- it wasn't working from begining (since I didn't found any user of 
smb347 in tree).

I work with gathered patches [2] and preparing them for upstream.
Testing is done on Nexus 7 2012, tilapia (grouper-nakasi3g).
Charging and discharging is reported by driver correctly.

Any ideas welcome!
Thank you
David

[1] "smb347 2-006a: reading IRQSTAT_D failed"
[2] https://github.com/okias/linux/commits/smb3xx-charger



