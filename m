Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150683EE6C4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhHQGnR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 02:43:17 -0400
Received: from server0.marangoni.cc ([37.120.170.113]:58534 "EHLO
        mail.marangoni.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhHQGnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 02:43:17 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 02:43:17 EDT
X-Virus-Scanned: Yes
To:     linux-pm@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marangoni.cc; s=mail;
        t=1629182030; bh=N7MRsHZirAOdVo+jw2sXntV/R5/ln0UOFC8rRifO5dY=;
        h=To:From:Subject;
        b=Su0lDFYaiSMmG5LkjkSdadIrGQbjUFv8QSNCpWRPBXS8hJnlz/x36Wp5MPFHjk0rd
         tJLORWi0c6ldkgvgOddFk0KGhZahixdrjmrBg3PFLn99EZNyVXf2/dfYJnJlU8k5gJ
         1AhY6UTjbWNtxHJWOlkogMYQXj0GviJ8CtxBorOj8kzViRZeQSXrOxukRz/HX/uwgT
         M/tpk8wPBoKkCGXKRDKAg55I8SURF/kJdCfvFIYt8PaQvau8xAOwI1+bbOjR6awMH9
         kZkDoHdGYSnaTh4JHm9sqapMWWJ6qdUI6lDeot80NpBxOFeELHYUtNhfgHDvFrnAtP
         2sACBPtpZVFOQ==
From:   Thomas Marangoni <thomas@marangoni.cc>
Subject: Define own attributes in power supply driver
Message-ID: <95324fdb-20c1-3286-0223-09ff62d8957d@marangoni.cc>
Date:   Tue, 17 Aug 2021 08:33:50 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,
I'm new to developing kernel drivers and want to improve the driver of 
the axp209 battery driver. I've read the documentation about the Linux 
power supply class 
(https://www.kernel.org/doc/html/latest/power/power_supply_class.html) 
and there it says: "Power supply class is extensible, and allows to 
define drivers own attributes.". The problem is I couldn't find any 
documentation or example of how to add own attributes. My goal is to 
have an own attribute showing up at /sys/class/power_supply/axp20x-battery/

Is there any example on how to do that or any documentation I didn't found?

Thanks for your help!

