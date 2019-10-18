Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD0DBE3B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 09:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504546AbfJRHVe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 03:21:34 -0400
Received: from cmta16.telus.net ([209.171.16.89]:60268 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389778AbfJRHVe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 03:21:34 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id LMZlipEwUFXoiLMZnibfHH; Fri, 18 Oct 2019 01:21:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1571383292; bh=8Dt/ADD4haBNVlYJk2iSLe3VCkpuPv37431jbrEJCag=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=p8k45CaaBZCgXc9wh13CEOWRyccmJ/APQx8xg4DoBNIAVuiYOSxYE/26TO+0PQYzy
         bD0Bva1RzU/cW8q0ZOUFijDNsruQRDbzo2hPCdEMHnGN589xDFOl7YvzWmSPqhAk3l
         fsD/lIUg8oTUvnOpdG/oSvtIFdfPzoqPCzbVpKHvk8SPRFco3lgn7ACN6ZyX9cAHsx
         vhPkC2d1UoaAOfCBXBwePHAGcIbJ1t8eA3/fjzHNI6dlLRNFD3wyvqK0LBMwRZgYvR
         9XPx41ow7GTS/vBmfIdgfH57VfTU1PmY/28N4Vtxm/M5ONQ2nbjzoOXceGbXlCK21i
         bRNaL77tRtOBg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=8DIIB-m8ztohKZRtoFUA:9 a=CjuIK1q_8ugA:10
 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <60416800.X4hXmAfbqi@kreacher>
In-Reply-To: <60416800.X4hXmAfbqi@kreacher>
Subject: RE: [PATCH 0/4] cpuidle: teo: Fix issues related to disabled idle states
Date:   Fri, 18 Oct 2019 00:21:27 -0700
Message-ID: <000901d58584$a961bdb0$fc253910$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV/snrkBE1H5zQJSNaSwKVTXZlSCAFTnm9Q
X-CMAE-Envelope: MS4wfIgbN1ynfXk3bF6h5oPTomzfvRUZ9XzTyyNw8yHxOQeNoF+Km8FtCv2P0k3Iu5VqdYpIs6GBUWGPCTu4StG7tKVLswPj6BCcONR/pg5AAj++YATQTSyM
 jVVZpeGp72OZqStZxd5+y8sWhZh6duR1Z/a3U55MFrBioDcC4AUVTNQqjO2fD13TEgJjM37tIDp9eokKK2XtA0vPsi6dgfCy3wL9Qya7nnR/wa2zUoRi1X0V
 xDvk+Dh/ssretz2+se4A/Bqk10PBcqv+8cRNOM7/hBDvT7qxg7c+UpjYdoNXwICd2m1ILqBD9xJg3zVe/gWlHfHoU7yEjoJfZr6GZYJh4qXY7/JgxhpJgPIz
 /QEY3Fv7
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.10 Rafael J. Wysocki wrote:

> There are a few issues related to the handling of disabled idle states in the
> TEO (Timer-Events-Oriented) cpuidle governor which are addressed by this
> series.
>
> The application of the entire series is exactly equivalent to the testing patch
> at https://lore.kernel.org/lkml/3490479.2dnHFFeJIp@kreacher/ , but IMO it is
> cleaner to split the changes into smaller patches which also allows them to
> be explained more accurately.

Hi,

I have re-tested and continued testing using this 4 patch set.

Summary: So far, everything is fine.

Some, but not all, detail:

Reference kernel: 5.4-rc2 "stock"
Test kernel: 5.4-rc2 + this 4 patch set "rjw-4"

Test 1: Where I simply coded, to automate, my best use
case example:

This is an idle state 4 disabled test.
The max entries column is entries and exits for
idle state 0 over the test sample interval
(15 seconds in this case).

stock kernel:

idle-doug01 : begin ...

Per CPU PASS/FAIL : Totals: fail rate: max entries:
 0 1 2 3 4 5 6 7  :       : (percent):            :
 . . F . . . F .  :      8 : 25.0000 :      69939
 . . F . . . F .  :     16 : 25.0000 :      69938
 . . F . . . F .  :     24 : 25.0000 :      70126
...
 . . . . . . F F  :   1928 : 30.8610 :      66530
 . . . . . . F F  :   1936 : 30.8368 :      68451
 . . . . . . F F  :   1944 : 30.8128 :      68643
 . . . . . . F F  :   1952 : 30.7889 :      68645
 . . . . . . F F  :   1960 : 30.7653 :      68152
 . . . . . . F F  :   1968 : 30.7419 :      67145
 . . . . . . F F  :   1976 : 30.7186 :      67349
 . . . . . . F F  :   1984 : 30.6956 :      68481
 . . . . . . F F  :   1992 : 30.6727 :      67394
 . . . . . . F F  :   2000 : 30.6500 :      68645
^C --- SIGINT (^C) detected. Terminate gracefully, saving the sample data...
 . . . . . . F F  :   2008 : 30.6275 :      29010

Summary: Total Tests:   2008 : Total Fails:    615 : Fail rate (percent): 30.6275 : Per CPU:
CPU00:      0, CPU01:      0, CPU02:     12, CPU03:      0, CPU04:    152, CPU05:     43, CPU06:    197, CPU07:    211,

idle-doug01 : end ...

rjw-4 kernel:

idle-doug01 : begin ...

Per CPU PASS/FAIL : Totals: fail rate: max entries:
 0 1 2 3 4 5 6 7  :       : (percent):            :
 . . . . . . . .  :      8 :  0.0000 :          3
 . . . . . . . .  :     16 :  0.0000 :          7
 . . . . . . . .  :     24 :  0.0000 :         10
 . . . . . . . .  :     32 :  0.0000 :         10
 . . . . . . . .  :     40 :  0.0000 :         23
 . . . . . . . .  :     48 :  0.0000 :         23
 . . . . . . . .  :     56 :  0.0000 :          1
 . . . . . . . .  :     64 :  0.0000 :          1
 . . . . . . . .  :     72 :  0.0000 :          0
 . . . . . . . .  :     80 :  0.0000 :          0
 . . . . . . . .  :     88 :  0.0000 :          1
 . . . . . . . .  :     96 :  0.0000 :          1
 . . . . . . . .  :    104 :  0.0000 :          0
 . . . . . . . .  :    112 :  0.0000 :          0
 . . . . . . . .  :    120 :  0.0000 :          1
 . . . . . . . .  :    128 :  0.0000 :          2
 . . . . . . . .  :    136 :  0.0000 :          2
 . . . . . . . .  :    144 :  0.0000 :          3
 . . . . . . . .  :    152 :  0.0000 :          3
 . . . . . . . .  :    160 :  0.0000 :          4
 . . . . . . . .  :    168 :  0.0000 :          4
 . . . . . . . .  :    176 :  0.0000 :          6
 . . . . . . . .  :    184 :  0.0000 :          3
 . . . . . . . .  :    192 :  0.0000 :          4
...
 . . . . . . . .  :  11480 :  0.0000 :          5
 . . . . . . . .  :  11488 :  0.0000 :          4
 . . . . . . . .  :  11496 :  0.0000 :          6
 . . . . . . . .  :  11504 :  0.0000 :          8
 . . . . . . . .  :  11512 :  0.0000 :          5
 . . . . . . . .  :  11520 :  0.0000 :          4
 . . . . . . . .  :  11528 :  0.0000 :          4
 . . . . . . . .  :  11536 :  0.0000 :          3
 . . . . . . . .  :  11544 :  0.0000 :          2
 . . . . . . . .  :  11552 :  0.0000 :          5
 . . . . . . . .  :  11560 :  0.0000 :          3
 . . . . . . . .  :  11568 :  0.0000 :          3
^C --- SIGINT (^C) detected. Terminate gracefully, saving the sample data...
 . . . . . . . .  :  11576 :  0.0000 :          1

Summary: Total Tests:  11576 : Total Fails:      0 : Fail rate (percent):  0.0000 : Per CPU:
CPU00:      0, CPU01:      0, CPU02:      0, CPU03:      0, CPU04:      0, CPU05:      0, CPU06:      0, CPU07:      0,

idle-doug01 : end ...

Test 2: Have a look at all idle state enabled/disabled combinations.
This test is not very good, and only looks at processor package power.
Particularly for idle state 1, see Note 1 below.
But it's better than nothing.

stock kernel:

idle-disable-enable : begin ...

Idle State:  Per test PASS/FAIL  :     Power (Watts)    :
4 3 2 1 0 :                      :  Expected : Max diff :
0 0 0 0 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 0 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 0 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 0 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 1 0 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 1 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 1 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 0 1 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 0 0 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 0 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 0 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 0 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 1 0 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 1 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 1 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
0 1 1 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     3.7 :    0.2
1 0 0 0 0 : FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL :     4.9 :   17.0
1 0 0 0 1 : FAIL PASS PASS PASS PASS PASS PASS PASS :     4.9 :    1.6
1 0 0 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     4.9 :    0.8
1 0 0 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     4.9 :    0.8
1 0 1 0 0 : PASS FAIL FAIL FAIL FAIL FAIL FAIL FAIL :     4.9 :   19.9
1 0 1 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     4.9 :    0.9
1 0 1 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     4.9 :    0.8
1 0 1 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     4.9 :    0.8
1 1 0 0 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     8.7 :    0.7
1 1 0 0 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     8.7 :    0.7
1 1 0 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :     8.7 :    0.7
1 1 0 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :     8.7 :    0.7
1 1 1 0 0 : FAIL PASS PASS PASS PASS PASS PASS PASS :     9.6 :    2.5
1 1 1 0 1 : FAIL PASS PASS PASS PASS PASS PASS PASS :     9.6 :   11.3 <<< Note 1.
1 1 1 1 0 : PASS PASS PASS PASS PASS PASS PASS PASS :    52.0 :    1.0
1 1 1 1 1 : PASS PASS PASS PASS PASS PASS PASS PASS :    52.0 :    1.4

idle-disable-enable : end ...

rjw-4 kernel:

Note: Reduced to 3 tests per combination. 8 seconds per sample.

idle-disable-enable : begin ...

Idle State:  Per test PASS/FAIL  :     Power (Watts)    :
4 3 2 1 0 :                      :  Expected : Max diff :
0 0 0 0 0 : PASS PASS PASS :     3.7 :    0.2
0 0 0 0 1 : PASS PASS PASS :     3.7 :    0.2
0 0 0 1 0 : PASS PASS PASS :     3.7 :    0.2
0 0 0 1 1 : PASS PASS PASS :     3.7 :    0.2
0 0 1 0 0 : PASS PASS PASS :     3.7 :    0.3
0 0 1 0 1 : PASS PASS PASS :     3.7 :    0.2
0 0 1 1 0 : PASS PASS PASS :     3.7 :    0.2
0 0 1 1 1 : PASS PASS PASS :     3.7 :    0.3
0 1 0 0 0 : PASS PASS PASS :     3.7 :    0.2
0 1 0 0 1 : PASS PASS PASS :     3.7 :    0.3
0 1 0 1 0 : PASS PASS PASS :     3.7 :    0.3
0 1 0 1 1 : PASS PASS PASS :     3.7 :    0.2
0 1 1 0 0 : PASS PASS PASS :     3.7 :    0.2
0 1 1 0 1 : PASS PASS PASS :     3.7 :    0.2
0 1 1 1 0 : PASS PASS PASS :     3.7 :    0.3
0 1 1 1 1 : PASS PASS PASS :     3.7 :    0.3
1 0 0 0 0 : PASS PASS PASS :     4.9 :    0.8
1 0 0 0 1 : PASS PASS PASS :     4.9 :    0.8
1 0 0 1 0 : PASS PASS PASS :     4.9 :    0.8
1 0 0 1 1 : PASS PASS PASS :     4.9 :    0.8
1 0 1 0 0 : PASS PASS PASS :     4.9 :    0.8
1 0 1 0 1 : PASS PASS PASS :     4.9 :    0.8
1 0 1 1 0 : PASS PASS PASS :     4.9 :    0.8
1 0 1 1 1 : PASS PASS PASS :     4.9 :    0.8
1 1 0 0 0 : PASS PASS PASS :     8.7 :    0.8
1 1 0 0 1 : PASS PASS PASS :     8.7 :    0.8
1 1 0 1 0 : PASS PASS PASS :     8.7 :    0.9
1 1 0 1 1 : PASS PASS PASS :     8.7 :    0.9
1 1 1 0 0 : PASS PASS PASS :     9.6 :    1.7
1 1 1 0 1 : FAIL PASS PASS :     9.6 :    2.1  <<< Note 1.
1 1 1 1 0 : PASS PASS PASS :    52.0 :    0.5
1 1 1 1 1 : PASS PASS PASS :    52.0 :    1.0

idle-disable-enable : end ...

Note 1:
The processor package power used in idle state 1 is
a strong function of the current p-state setting:
p-state 16 (lowest): 8.8 watts
p-state 38 (highest): 21.9 watts
When the system load goes to idle during this test,
it can take on the order of 10s of seconds for the
intel-pstate driver to request low p-states for
all CPUs. If there is an issue here, it is a subject
for another day.

... Doug


