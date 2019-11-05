Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4AF0647
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKETvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 14:51:02 -0500
Received: from cmta17.telus.net ([209.171.16.90]:34631 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfKETvC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 14:51:02 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id S4qwiWGx0bg38S4qxiTdH1; Tue, 05 Nov 2019 12:51:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572983460; bh=Hr2YMJ1ZfQYlH43F0mQyo2gi/XKK9mF4Jrvjk025Lag=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=IQTfetl5+3wId2+RnQJS0XT2jVGXESDVeeAdajXBIXbFe9IP80qJPTGtdJii4T/uK
         9pNz6702Pe9p1X/1SzIJzz/wijwQhIzIUWjkD9xyTSjBjAFh27VEugdOXFXtbUX4Yj
         boCvMSA07O5W3a/HBsa95PBHvn4mQYaFebSWKS5ZMpSwXn5b0Fhk7M2fNOncf3zLPR
         UPUFvrq2wzAsL/2gFgIAUXrTfdTXcWqaYpjuy1l3B8/SMUIXvhgV++0WFx0m+cOFsR
         hwAMDR5y0LoDkl6RpGGudQughRjFZhhvQ8La/yUS37M5xOdgWHR/NdH4n+/Avg9lCi
         yge9mx08Dqc/A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=rAq7UpmyHFtLT1OCutkA:9
 a=netjI_sRjhY9QG3l:21 a=KFigGKmJXnE7LcBR:21 a=CjuIK1q_8ugA:10
 a=jQRHTDX4f64A:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <60416800.X4hXmAfbqi@kreacher> <1746940.X44tFrgt99@kreacher>
In-Reply-To: <1746940.X44tFrgt99@kreacher>
Subject: RE: [PATCH 4/4] cpuidle: teo: Fix "early hits" handling for disabled idle states
Date:   Tue, 5 Nov 2019 11:50:56 -0800
Message-ID: <001701d59412$5804f620$080ee260$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV/svNL1SGyn6VuSRenWSHfKDOrigUXgi5Q
X-CMAE-Envelope: MS4wfPTo3Tg79I5gcuqTg0S8haGff6gCV7l9YRfbgkZeCEg3EQTeTOV8SnrYUDGJGAP2WlEKHb8FUGvUzzN6/sHz757OAgajzOAa16IVoqpNBeGyQ3tX7a1U
 fqihNDzZZC5O1EQ8wxXe3xolk8+NGJ3bpEx6FRJmLvvaALzrS2P333dyfkMjSQswciPPVx8eRkd7laBv9xetbZVAq+7XCkLCYRl2JiFw4ZqYvaH+Gq8eFwhF
 DgSRLctwzpHVGIKV3LArd9Ia/qidj/y8ga1Dbj3dqIZgyoMe5yyuzzxBVlRU1VVbTtMTIVNFpkmdRuedwuZnjYm1J+vXHvSGg7CYaBl8+YGi65z9bjpc3fKn
 8QREqsFz
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.10 14:38 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The TEO governor uses idle duration "bins" defined in accordance with
> the CPU idle states table provided by the driver, so that each "bin"
> covers the idle duration range between the target residency of the
> idle state corresponding to it and the target residency of the closest
> deeper idle state.  The governor collects statistics for each bin
> regardless of whether or not the idle state corresponding to it is
> currently enabled.
>
> In particular, the "early hits" metric measures the likelihood of a
> situation in which the idle duration measured after wakeup falls into
> to given bin, but the time till the next timer (sleep length) falls
> into a bin corresponding to one of the deeper idle states.  It is
> used when the "hits" and "misses" metrics indicate that the state
> "matching" the sleep length should not be selected, so that the state
> with the maximum "early hits" value is selected instead of it.
>
> If the idle state corresponding to the given bin is disabled, it
> cannot be selected and if it turns out to be the one that should be
> selected, a shallower idle state needs to be used instead of it.
> Nevertheless, the metrics collected for the bin corresponding to it
> are still valid and need to be taken into account as though that
> state had not been disabled.
>
> As far as the "early hits" metric is concerned, teo_select() tries to
> take disabled states into account, but the state index corresponding
> to the maximum "early hits" value computed by it may be incorrect.
> Namely, it always uses the index of the previous maximum "early hits"
> state then, but there may be enabled idle states closer to the
> disabled one in question.  In particular, if the current candidate
> state (whose index is the idx value) is closer to the disabled one
> and the "early hits" value of the disabled state is greater than the
> current maximum, the index of the current candidate state (idx)
> should replace the "maximum early hits state" index.
>
> Modify the code to handle that case correctly.
> 
> Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I tested this pretty patch set thoroughly, but can not claim exhaustively.
I did my best to mess it up via trying weird scenarios.
Unrelated issues discovered during testing are being handled on
other e-mail threads.

Tested-by: Doug Smythies <dsmythies@telus.net>


