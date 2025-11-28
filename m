Return-Path: <linux-pm+bounces-38906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AEC934CE
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B173A9A37
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267C23E325;
	Fri, 28 Nov 2025 23:45:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC5134AB;
	Fri, 28 Nov 2025 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764373553; cv=none; b=Z86gmThv5lq1Fkx458PeDwSE1kI5OklFyWYY04zZ0DDy7Xs+rBcoqlPf3oRwcWJR8E33C5T25qkL5MOwLWNDOYJT+yd292ynAveJ8Qne+BWrb1XNhrOQ95Jeir3EDQje99DJVGWt/B5Y8d4GvHI6pzEjgYBCXCdrJ1FgLDvGxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764373553; c=relaxed/simple;
	bh=jhn+L4wjHS7yWQa9IpUSmUvhsEMoYD6sXqpua8hK5os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq0EGM6kO30T8YYtBXCwuVCXVteq9TU/hJebA9MIwUgDPI8t9s2XtEjsasSNw9kMYiCa47AnbFgTEcRkQOmQr0mXvnrtrXxZkBmIotHMluPw/FRabdvTxPXIqOo1EtZIwZPwYcSZAvuF5vl5DVnpdw09Y/EOtvO8MG1kBdtr+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD101007;
	Fri, 28 Nov 2025 15:45:42 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD533F6A8;
	Fri, 28 Nov 2025 15:45:49 -0800 (PST)
Message-ID: <e4c093f0-ebb1-470d-8318-017a72c31eb6@arm.com>
Date: Fri, 28 Nov 2025 23:45:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] cpuidle: governors: teo: Fix and simplification
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <12810244.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12810244.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 12:31, Rafael J. Wysocki wrote:
> Hi,
> 
> This series is based on
> 
> https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
> 
> and the previous teo updates sent recently.
> 
> It fixes a reverse condition in teo_update() (first patch) and quite
> dramatically simplifies the "intercepts" logic in teo_select() (second
> patch).
> 

FWIW nothing note worthy in my tests, as expected.
Tested-by: Christian Loehle <christian.loehle@arm.com>

teo-0 is the with the mentioned baseline:
device     gov        iter     iops      idles  idle_miss      ratio     belows     aboves
mmcblk1    teo-0      0      2331     643796         88      0.000         56         32
mmcblk1    teo-0      1      2327     624534        120      0.000         36         84
mmcblk1    teo-0      2      2352     642172         33      0.000         22         11
mmcblk1    teo-1      0      2330     626270         89      0.000         41         48
mmcblk1    teo-1      1      2330     641274         16      0.000         15          1
mmcblk1    teo-1      2      2344     644533         58      0.000         44         14
mmcblk1    teo-2      0      2331     639104         44      0.000         31         13
mmcblk1    teo-2      1      2327     606128        110      0.000         33         77
mmcblk1    teo-2      2      2352     582654         50      0.000         35         15
mmcblk2    teo-0      0      5704     903238        260      0.000        245         15
mmcblk2    teo-0      1      5605     717534       4586      0.006       4572         14
mmcblk2    teo-0      2      5669     798154         61      0.000         34         27
mmcblk2    teo-1      0      5662     748450         78      0.000         36         42
mmcblk2    teo-1      1      5646     688848        105      0.000         60         45
mmcblk2    teo-1      2      5687     836774         32      0.000         27          5
mmcblk2    teo-2      0      5695     911770         35      0.000         23         12
mmcblk2    teo-2      1      5669     762958         85      0.000         50         35
mmcblk2    teo-2      2      5639     625948        150      0.000         98         52
nvme0n1    teo-0      0     11274     823656         62      0.000         44         18
nvme0n1    teo-0      1     11761     846600         70      0.000         41         29
nvme0n1    teo-0      2     10488     779408        121      0.000         56         65
nvme0n1    teo-1      0     11822     859692         71      0.000         34         37
nvme0n1    teo-1      1     10486     773748        223      0.000         44        179
nvme0n1    teo-1      2     10624     782348        222      0.000         45        177
nvme0n1    teo-2      0     10488     765694        122      0.000         31         91
nvme0n1    teo-2      1     10661     785510        150      0.000         47        103
nvme0n1    teo-2      2     10519     775320        173      0.000         44        129
nullb0     teo-0      0    103101     111844         50      0.000         28         22
nullb0     teo-0      1    104242     111172        270      0.002        156        114
nullb0     teo-0      2    103724     115100        359      0.003        203        156
nullb0     teo-1      0    103315     113054        142      0.001         49         93
nullb0     teo-1      1    103155     114067        143      0.001         41        102
nullb0     teo-1      2    103910     112446        182      0.002         32        150
nullb0     teo-2      0    104451     113320        118      0.001         40         78
nullb0     teo-2      1    103130     112782        190      0.002         38        152
nullb0     teo-2      2    102745     114172        147      0.001         45        102
mtdblock3  teo-0      0       250     931002      12700      0.014      12694          6
mtdblock3  teo-0      1       257     937274        220      0.000        207         13
mtdblock3  teo-0      2       261     300176         91      0.000         41         50
mtdblock3  teo-1      0       257     912068        109      0.000         65         44
mtdblock3  teo-1      1       257     848038        161      0.000        135         26
mtdblock3  teo-1      2       261     311794         74      0.000         36         38
mtdblock3  teo-2      0       255     953540       3440      0.004       3434          6
mtdblock3  teo-2      1       260     514246         60      0.000         37         23
mtdblock3  teo-2      2       260     427200        682      0.002        645         37

test       gov        i     score  %change    idles  idle_miss  miss_rt   belows   aboves
schbench   teo-0      0    194.07    +0.00%    25308        6    0.000        5        1
schbench   teo-0      1    194.53    +0.24%    25490        7    0.000        6        1
schbench   teo-0      2    194.37    +0.15%    25040        6    0.000        6        0
schbench   teo-0      3    194.00    -0.04%    25040        4    0.000        4        0
schbench   teo-0      4    207.80    +7.07%    26324        6    0.000        6        0
schbench   teo-1      0    189.80    -2.20%    23776        2    0.000        2        0
schbench   teo-1      1    188.13    -3.06%    24790        5    0.000        5        0
schbench   teo-1      2    189.63    -2.29%    24870       19    0.001       18        1
schbench   teo-1      3    187.40    -3.44%    24606        6    0.000        6        0
schbench   teo-1      4    187.17    -3.56%    24214        2    0.000        2        0
schbench   teo-2      0    188.70    -2.77%    24336        5    0.000        5        0
schbench   teo-2      1    185.23    -4.56%    24029        3    0.000        3        0
schbench   teo-2      2    188.87    -2.68%    24904        3    0.000        3        0
schbench   teo-2      3    186.97    -3.66%    24478        4    0.000        4        0
schbench   teo-2      4    210.07    +8.24%    27196        6    0.000        6        0
ebizzy     teo-0      0  10688.00    +0.00%     1096        7    0.006        6        1
ebizzy     teo-0      1  10668.00    -0.19%     1132       11    0.010        9        2
ebizzy     teo-0      2  10696.00    +0.07%     1066        6    0.006        5        1
ebizzy     teo-0      3  10702.00    +0.13%     1056        7    0.007        4        3
ebizzy     teo-0      4  10635.00    -0.50%     1206        8    0.007        7        1
ebizzy     teo-1      0  10724.00    +0.34%     1216       11    0.009        8        3
ebizzy     teo-1      1  10747.00    +0.55%     1240        7    0.006        5        2
ebizzy     teo-1      2  10715.00    +0.25%     1118        7    0.006        6        1
ebizzy     teo-1      3  10698.00    +0.09%     1144        6    0.005        4        2
ebizzy     teo-1      4  10735.00    +0.44%     1203        9    0.007        7        2
ebizzy     teo-2      0  10678.00    -0.09%     1114        9    0.008        8        1
ebizzy     teo-2      1  10697.00    +0.08%     1186        6    0.005        5        1
ebizzy     teo-2      2  10713.00    +0.23%     1162       11    0.009        9        2
ebizzy     teo-2      3  10512.00    -1.65%     1190        8    0.007        8        0
ebizzy     teo-2      4   9890.00    -7.47%     1150       13    0.011       11        2
adrestia   teo-0      0     12.00    +0.00%   103584       15    0.000       14        1
adrestia   teo-0      1     12.00    +0.00%   103298       20    0.000       10       10
adrestia   teo-0      2     12.00    +0.00%   103248       29    0.000       18       11
adrestia   teo-0      3     12.00    +0.00%   103484       23    0.000       15        8
adrestia   teo-0      4     12.00    +0.00%   103362       29    0.000       20        9
adrestia   teo-1      0     12.00    +0.00%   103942       14    0.000       13        1
adrestia   teo-1      1     12.00    +0.00%   103521       18    0.000        9        9
adrestia   teo-1      2     12.00    +0.00%   103642       19    0.000       10        9
adrestia   teo-1      3     12.00    +0.00%   103534       17    0.000       11        6
adrestia   teo-1      4     12.00    +0.00%   103214       14    0.000        6        8
adrestia   teo-2      0     12.00    +0.00%   103270        8    0.000        6        2
adrestia   teo-2      1     12.00    +0.00%   103364       22    0.000       13        9
adrestia   teo-2      2     12.00    +0.00%   103588       17    0.000        6       11
adrestia   teo-2      3     12.00    +0.00%   103906       22    0.000       17        5
adrestia   teo-2      4     12.00    +0.00%   103218       12    0.000        3        9
hackbench  teo-0      0     21.38    +0.00%    14764        8    0.001        5        3
hackbench  teo-0      1     21.57    +0.86%    17512       16    0.001       13        3
hackbench  teo-0      2     21.60    +1.02%    15664       16    0.001       15        1
hackbench  teo-0      3     21.76    +1.74%    20614       12    0.001       11        1
hackbench  teo-0      4     21.61    +1.05%    18614       10    0.001       10        0
hackbench  teo-1      0     21.59    +0.95%    15952       11    0.001        8        3
hackbench  teo-1      1     21.73    +1.64%    16618        9    0.001        8        1
hackbench  teo-1      2     21.46    +0.34%    15084       12    0.001        9        3
hackbench  teo-1      3     21.57    +0.86%    13264       16    0.001       14        2
hackbench  teo-1      4     21.53    +0.69%    12514       10    0.001        9        1
hackbench  teo-2      0     21.63    +1.16%    15236       12    0.001        8        4
hackbench  teo-2      1     21.74    +1.66%    15748       12    0.001       11        1
hackbench  teo-2      2     21.72    +1.59%    17514       11    0.001       11        0
hackbench  teo-2      3     21.67    +1.32%    14972       11    0.001        9        2
hackbench  teo-2      4     21.85    +2.19%    18396       14    0.001       11        3

