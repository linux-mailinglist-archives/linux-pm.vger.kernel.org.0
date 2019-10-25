Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC53E4A05
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJYLcx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 07:32:53 -0400
Received: from comms.puri.sm ([159.203.221.185]:48618 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJYLcx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 07:32:53 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 07:32:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2785FDFFDB;
        Fri, 25 Oct 2019 04:23:11 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n3Wpa7Rk3YNc; Fri, 25 Oct 2019 04:23:10 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        leo.yan@linaro.org, edubezval@gmail.com,
        vincent.guittot@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Fri, 25 Oct 2019 13:22:55 +0200
Message-Id: <20191025112255.9253-1-martin.kepplinger@puri.sm>
In-Reply-To: <34b1ed94-1223-60ec-ac4f-0b32be67eab2@linaro.org>
References: <34b1ed94-1223-60ec-ac4f-0b32be67eab2@linaro.org>
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Quick note: You're missing a kref_init() in this version of the cooling driver.

Also, as already mentioned, set_freezable() doesn't seem to work without
supporting suspend/resume.

And since cpuidle got somewhat completely reworked in 5.4, could you create
a new, rebased version of this? Let me know in case I missed an earlier update.

thanks,

                              martin


---
