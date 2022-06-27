Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8255D784
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiF0NYI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiF0NYG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 09:24:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3F6363
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 06:24:04 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656336243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Kg/N4ozm1cY0UCEXrhIi7QsDEZkJ0yuMescOin7QN3Q=;
        b=orMm8rjFbJ5nC19PIn0s1F+olo0w0/WhToBOjbMzqGyNcjoBOqaMX2/py4C35xgLiY6Ymi
        9CouWsFJemB1k7ytu3CH7gIzQiaYi0W2dgmAPBokXDhvMhq7onMW4OO1yjBj3HKYTucpKh
        77j42bv/msJpy55DVpZJ8ycpEu4IZha5vY4WLOoNELsnAKIUnaedoiBHHepVYR0gx49F65
        9RCt0czkSF2/Nl7T1Qwu29fpQ5MyRHA0MYpMy4+ge+BfmOlsnBWFZb6iX6ztGO2dbq+L/R
        DctDs7T4xu4p788sFNcVYOKY8EH1fqBtXTO4PlacegfE2ZaLbSSw65w+zwD1eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656336243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Kg/N4ozm1cY0UCEXrhIi7QsDEZkJ0yuMescOin7QN3Q=;
        b=kgAVqBnJDvCLZS7c7895VSTyTT1lcfXufWBm8KucY1ED1Oyh4/xjXqyDkcmsIC04aNdEN7
        Xyds1hITYoHuEFDA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     linux-pm@vger.kernel.org
cc:     rafael@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: cpufreq - powernv driver
Message-ID: <4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

during my work on a timer hierarchy I stumbled over powernv cpufreq driver
which is using a timer which is deferrable and pinned. This is the only
timer in kernel which uses this combination and I would like to get rid of
it.

Only removing the pinned or deferrable flag could not be the proper
solution, right?

I'm not familiar with cpufreq. I was wondering if it's possible to rework
the powernv cpufreq driver to use cpufreq infrastructure instead handling
it's own timer for ramping down? I would be happy if someone could help me
with some pointers how this could be solved.

Thanks,

      Anna-Maria
