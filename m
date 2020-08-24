Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B072A250043
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgHXO6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 10:58:21 -0400
Received: from cmta19.telus.net ([209.171.16.92]:38114 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXO5a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 10:57:30 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ADs7kzTNopULuADs8k2802; Mon, 24 Aug 2020 08:54:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1598280898; bh=J3BJ7qX7HVt5vAQT7eANT29lUGuCe6JLwEzkmWDSZh4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=aujTPU5q0SWxI9dXbNemMM2wZfAJfyN3DMY5OMLYBI4UVfmY1BviO/ySRAUq6eELC
         lO8z7h/3eCL31F6WR4LATLiru0AfOOE2o/uKp3RMPt8tqQURtDCCVsPgPEWNn423yY
         +rI27kp6tqriuYAIZpsKnChNvHSy1y+j4yjf7HQMOGv32AAxia7GxfG3JK1nitH313
         SiDyP2RYw53Tx2hLdkYylUCjLLCU54SS91yTrdLMV9jEZsRFABrEq8QR0PV14RUqG0
         NxFjlvoNpCfnTh1CmX2S+OwOGMuw/U4QMk92S9TGQcIWy9c7i2DgqhN0J1ODlSqyqd
         kx3VDQX/CEtpw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8
 a=cUYKOWGz9U0kq_ISi6IA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <3169564.ZRsPWhXyMD@kreacher>
In-Reply-To: <3169564.ZRsPWhXyMD@kreacher>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Mon, 24 Aug 2020 07:54:54 -0700
Message-ID: <000f01d67a26$891b9340$9b52b9c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYvk3X5bnwqpX6hRwi7ciAthJfS0BKjLYKg
X-CMAE-Envelope: MS4wfOmjarjI9dsl1fU5e3KC3UMjpvV86vTn7EqucnGmaYrvCTJMINyW1WAcl5RIEfPIyez1VwmkpoBOhjwxq0cQooS8KsWwvbzM+Kimxtun2h0rx1xQ4S4A
 KatdgSXQGwJgJ4lqX8flOjl6mTJXwBh3gEkSXzly/uBvMpdKXOWjKm9w83w5GU/ZEGbJvXR+zOr3+KHXQO2HlMj+iO06zAneBZ+fMv1PnUJ0Rvo4k1AK8ldw
 l+I/6ND2WpxO1fFl0uVL7qwkP4OMzTF+waySQZC6KgL4nPPePJYpNfpYnvXI7zDucVrHCn/LCMuojwGa4D9iW5tO0rDo+Z9vP/fD6WzBUkcDHAvomsSbXR0+
 pP8SnzMe0ATFLg0xqTwAxU7VQjAOzvy/JWNRLH0K+zJzj1cKPQj7O5/rsWP+JOUYmpnknS4E
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.21 10:16 Rafael J. Wysocki wrote:

...
> 
> The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very well
> may turn out to be either too high or too low for the general use, which is one
> reason why getting as much testing coverage as possible is key here.
> 
> If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
> please do so and let me know the conclusions.
...

Hi Rafael,

Since my v7 reply the other day about results for 347 Hz work/sleep frequency
periodic workflows [1], I have been testing at 73 Hertz work/sleep frequency.
And am now testing this:

-#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP     5000
+#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP     10000

Which shows promise for the schedutil governor, which no
longer drives prematurely into the turbo range, consuming
excessive amounts of energy as compared to passive without
HWP.

The ondemand governor is still very bad. The only way I
have found to get it behave is to force max=min=target_pstate,
in addition to the above.

It will be quite some time before I have well organized feedback.
In the meantime if anyone has suggestions for an optimal
INTEL_CPUFREQ_TRANSITION_DELAY_HWP value, I would be grateful.
Otherwise I'll attempt to find it via tests.

... Doug

[1] https://marc.info/?l=linux-pm&m=159769839401767&w=2


