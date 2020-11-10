Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92B22AE1F1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 22:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgKJVjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 16:39:06 -0500
Received: from cmta16.telus.net ([209.171.16.89]:45881 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJVhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 16:37:07 -0500
Received: from dougxps ([173.180.45.3])
        by cmsmtp with SMTP
        id cbK1kTpijRYCLcbK2kWwMz; Tue, 10 Nov 2020 14:37:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1605044224; bh=6RjS39imp4A53kCw78FIMCvUMdoDh1IXVgnkUAf3UMg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=T1z9fXpqwau1NgKWRAOiyB6Jic4n6eTuEhjfajeNFNnsNIpSL6z8jdS8TWAffHbo0
         X2nMsgeAOKfnyXU2Ewy49CcCiNWCY4qyA49zxNbGFfXRfR5w6nseFSYISaZXPzAzVr
         LKblQPFZ3ikvoVhAjX9Qif3Nrh/ewGIUHEzm1ltFkpCqpXcmXrGcpWglDuY5IidxI8
         eiS8YbNtnRe74M7cE9sR1A3/DyKOjygZuc7lUTSTgSIB0TYpkfn+3xPQIoBo3gb8M/
         /tlCBuFRZ7EiGtAFpMd2DMcQQAcpOqpbAqiMZ0OQARDTpUa/lTBjphzbjlmZbzVm6g
         4r7EgtmuEkfeQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=ReVVt3hv c=1 sm=1 tr=0 ts=5fab0800
 a=ZeVyObKPoMU90SgYCeSZ1g==:117 a=ZeVyObKPoMU90SgYCeSZ1g==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=acWEPiQgkH2VWHeUEa0A:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <13269660.K2JYd4sGFX@kreacher> <11312387.r5AVKgp8zO@kreacher>
In-Reply-To: <11312387.r5AVKgp8zO@kreacher>
Subject: RE: [PATCH v3 0/4] cpufreq: intel_pstate: Handle powersave governor correctly in the passive mode with HWP
Date:   Tue, 10 Nov 2020 13:37:00 -0800
Message-ID: <000d01d6b7a9$a1abdf80$e5039e80$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: Ada3huWgkL5djedHQomhtWyn688yUAAH3TGw
X-CMAE-Envelope: MS4xfLVijRtsDugUe7KJYTX4tlRXrQiAD2LZuGJtWUE4edhXcSDDU8MwGOxBF9r2xHeamcjZQEm5oq7cEedqNVNzzq9nKj3Q9BoVkia2PU1DiFKS51N9eWUz
 dZnlpkCCMVUAisZO8mAIyf3VcZ7hUdXVy/RXJVzjkoK5yOrMLHaxA1PTnP8KaVLmKFDN2WMGlKsO5U69GbV+spCJYnfYRxqNti5+HreC3GsNfe3ut3icCEjy
 MIDCC1G3xg7OBwETGleeAJYfNGss/A/v0r3G6RiIHqZWSeI5AffnVQDI2weh40yhl9wzLXxrrsmNJh79xZvSQ/P5fQ73lY5FxfggjFAArSpUrjrsNlz4uAa7
 K9cDJMJWfZan+ac35aQWelmglUJyDYzAWvbIuIs1rP3IFn3vbEw=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.11.10 09:22 Rafael J. Wysocki wrote:
> On Monday, November 9, 2020 5:49:49 PM CET Rafael J. Wysocki wrote:
>>
>> Even after the changes made very recently, the handling of the powersave
>> governor is not exactly as expected when intel_pstate operates in the
>> "passive" mode with HWP enabled.
>>
>> Namely, in that case HWP is not limited to the policy min frequency, but it
>> can scale the frequency up to the policy max limit and it cannot be constrained
>> currently, because there are no provisions for that in the framework.
>>
>> To address that, patches [1-3/4] add a new governor flag to indicate that this
>> governor wants the target frequency to be set to the exact value passed to the
>> driver, if possible, and change the powersave and performance governors to have
>> that flag set.
>>
>> The last patch makes intel_pstate take that flag into account when programming
>> the HWP Request MSR.
> 
> The v3 simply uses different names for the new governor flags.

Thank you.

I tested v2, with positive results, as reported for v1. I do not have time to
re-test v3.

My input is to also default this flag to be set for the userspace and ondemand governors.

userspace: I tested with and without this flag set, and the flag is needed if
the user expects the scaling_setspeed to be enforced.
Disclaimer: I don't normally actually use the userspace governor.

ondemand: from my tests, the ondemand response more closely mimics acpi-ondemand with the flag set.
Power consumption has been better for the limited testing done.
However, it is also a function of work/sleep frequency for periodic workflows and a function of
INTEL_CPUFREQ_TRANSITION_DELAY_HWP. I am saying that my ability to support the suggestion to default
to setting the flag is a little weak.

... Doug


