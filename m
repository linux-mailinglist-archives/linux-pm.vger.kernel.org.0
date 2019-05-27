Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764202B277
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfE0Kvf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 06:51:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61860 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0Kvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 06:51:35 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 36bc135fddf03d66; Mon, 27 May 2019 12:51:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS CPUFREQ DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:BROADCOM STB AVS CPUFREQ DRIVER" 
        <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: Couple fixes
Date:   Mon, 27 May 2019 12:51:32 +0200
Message-ID: <3734641.73qX0VsHyn@kreacher>
In-Reply-To: <20190522184547.31791-1-f.fainelli@gmail.com>
References: <20190522184547.31791-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, May 22, 2019 8:45:45 PM CEST Florian Fainelli wrote:
> Hi Rafael, Viresh,
> 
> These patch series contains two minor fixes for the brcmstb-avs-cpufreq
> driver.
> 
> Florian Fainelli (2):
>   cpufreq: brcmstb-avs-cpufreq: Fix initial command check
>   cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency
> 
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

These look straightforward enough to me, but it would be good to get an ACK from the
driver maintainer for them.



