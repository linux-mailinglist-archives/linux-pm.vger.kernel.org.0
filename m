Return-Path: <linux-pm+bounces-37963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F46C587B5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60D4D4F8614
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BE2F60DF;
	Thu, 13 Nov 2025 15:21:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868732F5A24;
	Thu, 13 Nov 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047313; cv=none; b=N4YBzVMRgfhpKwpyGkPvbV3UsWMJNqI20D2BSVJx+GO6d7bMVeGbWT5M19mtnBBF+7PT/svoSSzRRkB9o8skjJynO9UTbu3ePZvp+4TwZjjVyUFYkh25n5nrBIl3B6EGFz5FLC6+bOmGKKZfhgePF1KEIQ23R6XQDJvT26sXeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047313; c=relaxed/simple;
	bh=Evx4i40xW1VPayCOinG0yuzfDTAqQedv5lHi+Jv9aSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu6h+SjlbvvvxlvaOhvPK/whJ9U3ZQmYay7m4LKgB5td8csZ7GJmwxABradyB0+eLyrCssRh9Ke4DPwvXDr7UIVjG+teJZy+KuRpML+CYfu3j4v1z4+u6Xgu0uECjp/7HV2CzBtEMaVC0fr9sWm0HlDL8txWBVvFm7t/P643uP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6153912FC;
	Thu, 13 Nov 2025 07:21:43 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B85743F66E;
	Thu, 13 Nov 2025 07:21:49 -0800 (PST)
Message-ID: <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
Date: Thu, 13 Nov 2025 15:21:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4701737.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 16:21, Rafael J. Wysocki wrote:
> Hi,
> 
> This is a bunch of teo cpuidle governor improvements, some of which are related
> to a bug report discussed recently:
> 
> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com/
> 
> The first patch fixes a bug that may cause an overly deep idle state
> to be selected when the scheduler tick has been already stopped.
> 
> Patch [2/4] removes an unnecessary function argument.
> 
> Patch [3/4] makes teo_update() to use s64 as the data type for its local
> variables more consistently.
> 
> The last patch reworks the governor's decay implementation to also decay
> metric values lower than 8.
> 

Tested-by: Christian Loehle <christian.loehle@arm.com>

Test results below, although there really isn't anything interesting in there.
teo-1 to teo-4 (patches 1 to 4 respectively are essentially indistinguishable from
teo-m = mainline)


device     gov        iter     iops      idles  idle_miss      ratio     belows     aboves
mmcblk1    teo-m      0      2330     644806         69      0.000         47         22
mmcblk1    teo-m      1      2328     642994        102      0.000         66         36
mmcblk1    teo-m      2      2352     644020         44      0.000         28         16
mmcblk1    teo-1      0      2324     582886        174      0.000         52        122
mmcblk1    teo-1      1      2350     584012         57      0.000         45         12
mmcblk1    teo-1      2      2329     642238         55      0.000         36         19
mmcblk1    teo-2      0      2327     627590         90      0.000         40         50
mmcblk1    teo-2      1      2328     640178         62      0.000         43         19
mmcblk1    teo-2      2      2327     590950        109      0.000         97         12
mmcblk1    teo-3      0      2328     644366         55      0.000         41         14
mmcblk1    teo-3      1      2327     642740         57      0.000         31         26
mmcblk1    teo-3      2      2327     638428         77      0.000         51         26
mmcblk1    teo-4      0      2326     614326        137      0.000         35        102
mmcblk1    teo-4      1      2328     639990         29      0.000         24          5
mmcblk1    teo-4      2      2327     643086         62      0.000         41         21
mmcblk1    teo-6-6    0      2329     596768       1753      0.003       1686         67
mmcblk1    teo-6-6    1      2330     600324       1527      0.003       1495         32
mmcblk1    teo-6-6    2      2331     600110       1439      0.002       1397         42
mmcblk1    teo-6-12   0      2347     741170          6      0.000          4          2
mmcblk1    teo-6-12   1      2329     782232          0      0.000          4          2
mmcblk1    teo-6-12   2      2328     775652         10      0.000          8          2
mmcblk2    teo-m      0      5758     860660         61      0.000         47         14
mmcblk2    teo-m      1      5731     827264        493      0.001        477         16
mmcblk2    teo-m      2      5700     861346         69      0.000         50         19
mmcblk2    teo-1      0      5663     848222        708      0.001        666         42
mmcblk2    teo-1      1      5648     704886        563      0.001        528         35
mmcblk2    teo-1      2      5655     705698        208      0.000        161         47
mmcblk2    teo-2      0      5697     908264        326      0.000        316         10
mmcblk2    teo-2      1      5656     720270        592      0.001        515         77
mmcblk2    teo-2      2      5641     673948        540      0.001        501         39
mmcblk2    teo-3      0      5675     724770        709      0.001        666         43
mmcblk2    teo-3      1      5675     792828       1144      0.001        892        252
mmcblk2    teo-3      2      5701     909848        660      0.001        332        328
mmcblk2    teo-4      0      5673     860736        798      0.001        791          7
mmcblk2    teo-4      1      5606     508886       1786      0.004       1727         59
mmcblk2    teo-4      2      5632     569238        104      0.000         73         31
mmcblk2    teo-6-6    0      5692     848824       1748      0.002       1685         63
mmcblk2    teo-6-6    1      5898     876180       1225      0.001       1215         10
mmcblk2    teo-6-6    2      5646     633846       2248      0.004       2199         49
mmcblk2    teo-6-12   0      5869    1009742          9      0.000          6          3
mmcblk2    teo-6-12   1      5644     775326          4      0.000          4          0
mmcblk2    teo-6-12   2      5671     904480          4      0.000          4          0
nvme0n1    teo-m      0     10342     765802        152      0.000         55         97
nvme0n1    teo-m      1     10703     789232        157      0.000         52        105
nvme0n1    teo-m      2     10405     770046         62      0.000         34         28
nvme0n1    teo-1      0     10687     782984         84      0.000         40         44
nvme0n1    teo-1      1     11326     829102         79      0.000         33         46
nvme0n1    teo-1      2     10636     780884        197      0.000         98         99
nvme0n1    teo-2      0     10951     803155        108      0.000         39         69
nvme0n1    teo-2      1     11468     837334         55      0.000         35         20
nvme0n1    teo-2      2     10410     773154        148      0.000         63         85
nvme0n1    teo-3      0     10701     787882        101      0.000         47         54
nvme0n1    teo-3      1     10403     767178         54      0.000         31         23
nvme0n1    teo-3      2     10749     785898        209      0.000         51        158
nvme0n1    teo-4      0     10462     768442        149      0.000         56         93
nvme0n1    teo-4      1     10642     777534         85      0.000         45         40
nvme0n1    teo-4      2     10486     775710        172      0.000         62        110
nvme0n1    teo-6-6    0     11507     798450       1564      0.002       1505         59
nvme0n1    teo-6-6    1     10499     735294       2009      0.003       1879        130
nvme0n1    teo-6-6    2     10598     740936       1756      0.002       1477        279
nvme0n1    teo-6-12   0     10542     922846         18      0.000         12          6
nvme0n1    teo-6-12   1     10482     922114         23      0.000         16          7
nvme0n1    teo-6-12   2     11046     940398         23      0.000         17          6
sda        teo-m      0      1269     778958        111      0.000        108          3
sda        teo-m      1      1268     831064       1064      0.001       1054         10
sda        teo-m      2      1270     803714       2044      0.003       2034         10
sda        teo-1      0      1273     776836        143      0.000        131         12
sda        teo-1      1      1272     801800       2043      0.003       2043          0
sda        teo-1      2      1270     788906        165      0.000        155         10
sda        teo-2      0      1271     763694         79      0.000         68         11
sda        teo-2      1      1270     753904         66      0.000         62          4
sda        teo-2      2      1272     806804         45      0.000         38          7
sda        teo-3      0      1271     812758       1497      0.002       1494          3
sda        teo-3      1      1270     800006         49      0.000         48          1
sda        teo-3      2      1272     829854        358      0.000        356          2
sda        teo-4      0      1270     886646        243      0.000        239          4
sda        teo-4      1      1269     820968         40      0.000         38          2
sda        teo-4      2      1272     835716        124      0.000        109         15
sda        teo-6-6    0      1257     591486       5450      0.009       5435         15
sda        teo-6-6    1      1265     788536       4412      0.006       4404          8
sda        teo-6-6    2      1254     788282       4470      0.006       4461          9
sda        teo-6-12   0      1274     841398          0      0.000       4461          9
sda        teo-6-12   1      1271     840824          0      0.000       4461          9
sda        teo-6-12   2      1272     923816          4      0.000          4          0
nullb0     teo-m      0    101284     114406        178      0.002         70        108
nullb0     teo-m      1    101381     112804        496      0.004        303        193
nullb0     teo-m      2    101716     100370        380      0.004        225        155
nullb0     teo-1      0    101353     101198        366      0.004        202        164
nullb0     teo-1      1    100571     105004        168      0.002         87         81
nullb0     teo-1      2    101311     110644         56      0.001         26         30
nullb0     teo-2      0    100961     113126        261      0.002        159        102
nullb0     teo-2      1    101346     111776        463      0.004        261        202
nullb0     teo-2      2    101287     109772        277      0.003        137        140
nullb0     teo-3      0    101448     113264        239      0.002        141         98
nullb0     teo-3      1    101077     112294        301      0.003         47        254
nullb0     teo-3      2    100097     116756        423      0.004        267        156
nullb0     teo-4      0     99562     109606         52      0.000         30         22
nullb0     teo-4      1    101131     113982        136      0.001         45         91
nullb0     teo-4      2    100618     113698        144      0.001         41        103
nullb0     teo-6-6    0    101295      74346       2369      0.032       2139        230
nullb0     teo-6-6    1    101299      75350       1943      0.026       1803        140
nullb0     teo-6-6    2    100578      73924       2317      0.031       2089        228
nullb0     teo-6-12   0    100005     269180          7      0.000          4          3
nullb0     teo-6-12   1    100705     315302          0      0.000          4          3
nullb0     teo-6-12   2    100861     293350          6      0.000          3          3
mtdblock3  teo-m      0       262     312586         66      0.000         47         19
mtdblock3  teo-m      1       259     635682        100      0.000         97          3
mtdblock3  teo-m      2       258     771110        128      0.000         89         39
mtdblock3  teo-1      0       256     601566       7409      0.012       7396         13
mtdblock3  teo-1      1       260     535040         75      0.000         55         20
mtdblock3  teo-1      2       259     702118       1844      0.003       1820         24
mtdblock3  teo-2      0       261     312978       1813      0.006       1789         24
mtdblock3  teo-2      1       255     891548       3095      0.003       3090          5
mtdblock3  teo-2      2       259     680754        234      0.000        223         11
mtdblock3  teo-3      0       259     649474        102      0.000         94          8
mtdblock3  teo-3      1       260     552324        223      0.000        182         41
mtdblock3  teo-3      2       258     734378       1562      0.002       1551         11
mtdblock3  teo-4      0       257     762430       2438      0.003       2430          8
mtdblock3  teo-4      1       252     894318       9326      0.010       9314         12
mtdblock3  teo-4      2       258     663502       1437      0.002       1421         16
mtdblock3  teo-6-6    0       258     782434       1611      0.002       1572         39
mtdblock3  teo-6-6    1       259     591852       1658      0.003       1532        126
mtdblock3  teo-6-6    2       262     274192       1523      0.006       1432         91
mtdblock3  teo-6-12   0       256     986250         11      0.000         10          1
mtdblock3  teo-6-12   1       258     853982         11      0.000          9          2
mtdblock3  teo-6-12   2       260     654184          7      0.000          6          1

test       gov        i     score  %change    idles  idle_miss  miss_rt   belows   aboves
schbench   teo-m      0       196    0      26276         12      0.000         10          2
schbench   teo-m      1       195   -0      25668         23      0.001         19          4
schbench   teo-m      2       208    6      26180         24      0.001         21          3
schbench   teo-m      3       191   -2      25384          4      0.000          3          1
schbench   teo-m      4       194   -1      26060         31      0.001         21         10
schbench   teo-1      0       195   -0      26476         10      0.000          9          1
schbench   teo-1      1       194   -1      24880          9      0.000          9          0
schbench   teo-1      2       194   -1      24540         10      0.000          8          2
schbench   teo-1      3       195   -1      26246         30      0.001         23          7
schbench   teo-1      4       194   -1      26060         15      0.001         11          4
schbench   teo-2      0       198    1      27150         19      0.001         13          6
schbench   teo-2      1       195   -0      25354          8      0.000          8          0
schbench   teo-2      2       194   -1      24396         21      0.001         18          3
schbench   teo-2      3       193   -1      26044         20      0.001         18          2
schbench   teo-2      4       195   -0      26444         22      0.001         20          2
schbench   teo-3      0       192   -2      24988         10      0.000          9          1
schbench   teo-3      1       193   -1      25936          9      0.000          7          2
schbench   teo-3      2       190   -3      25218         14      0.001         13          1
schbench   teo-3      3       191   -2      25612         12      0.000          9          3
schbench   teo-3      4       192   -2      24892         28      0.001         17         11
schbench   teo-4      0       197    1      26768         16      0.001         14          2
schbench   teo-4      1       193   -1      26352         15      0.001         13          2
schbench   teo-4      2       194   -1      26158         15      0.001         14          1
schbench   teo-4      3       203    4      27536         28      0.001         26          2
schbench   teo-4      4       192   -2      24806         19      0.001         15          4
schbench   teo-6-6    0       199    2      24676        128      0.005        121          7
schbench   teo-6-6    1       211    8      26794        127      0.005        117         10
schbench   teo-6-6    2       205    5      25026        140      0.006        125         15
schbench   teo-6-6    3       198    1      24816        196      0.008        174         22
schbench   teo-6-6    4       198    1      26604        236      0.009        218         18
schbench   teo-6-12   0       190   -3      24464          0      0.000        218         18
schbench   teo-6-12   1       190   -3      25274          0      0.000        218         18
schbench   teo-6-12   2       190   -3      25256          0      0.000        218         18
schbench   teo-6-12   3       199    2      26342          0      0.000        218         18
schbench   teo-6-12   4       188   -4      25508          0      0.000        218         18
ebizzy     teo-m      0     10733    0       1358          7      0.005          7          0
ebizzy     teo-m      1     10750    0       1206         12      0.010          8          4
ebizzy     teo-m      2     10699   -0       1950         24      0.012         23          1
ebizzy     teo-m      3     10773    0       1384         18      0.013         16          2
ebizzy     teo-m      4     10667   -1       2060         24      0.012         23          1
ebizzy     teo-1      0     10770    0       1858         22      0.012         19          3
ebizzy     teo-1      1     10719   -0       1258          4      0.003          4          0
ebizzy     teo-1      2     10704   -0       1422          5      0.004          5          0
ebizzy     teo-1      3     10719   -0       1568         16      0.010         14          2
ebizzy     teo-1      4     10802    1       1288         11      0.009         11          0
ebizzy     teo-2      0     10669   -1       1126         11      0.010          9          2
ebizzy     teo-2      1     10696   -0       1733         18      0.010         14          4
ebizzy     teo-2      2     10676   -1       1620         17      0.010         14          3
ebizzy     teo-2      3     10737    0       1332         10      0.008          9          1
ebizzy     teo-2      4     10696   -0       1290          8      0.006          8          0
ebizzy     teo-3      0     10650   -1       1448         12      0.008          9          3
ebizzy     teo-3      1     10689   -0       1470         12      0.008         12          0
ebizzy     teo-3      2     10642   -1       1612         19      0.012         15          4
ebizzy     teo-3      3     10705   -0       1462         10      0.007          8          2
ebizzy     teo-3      4     10717   -0       1798         21      0.012         19          2
ebizzy     teo-4      0     10625   -1       1324         12      0.009          8          4
ebizzy     teo-4      1     10705   -0       1430         12      0.008         11          1
ebizzy     teo-4      2     10671   -1       1818         19      0.010         16          3
ebizzy     teo-4      3     10688   -0       1616          8      0.005          8          0
ebizzy     teo-4      4     10724   -0       1882         11      0.006          9          2
ebizzy     teo-6-6    0     10659   -1       1442         58      0.040         46         12
ebizzy     teo-6-6    1     10653   -1       1144         43      0.038         41          2
ebizzy     teo-6-6    2     10696   -0       1256         37      0.029         35          2
ebizzy     teo-6-6    3     10710   -0       1168         43      0.037         38          5
ebizzy     teo-6-6    4     10696   -0       1166         47      0.040         43          4
ebizzy     teo-6-12   0     10709   -0       2186          0      0.000         43          4
ebizzy     teo-6-12   1     10687   -0       1688          0      0.000         43          4
ebizzy     teo-6-12   2     10689   -0       2806          0      0.000         43          4
ebizzy     teo-6-12   3     10734    0       1426          0      0.000         43          4
ebizzy     teo-6-12   4     10757    0       2346          0      0.000         43          4
adrestia   teo-m      0         8    0     103680         21      0.000         19          2
adrestia   teo-m      1        12   50     104026         31      0.000         16         15
adrestia   teo-m      2        12   50     104063         32      0.000         24          8
adrestia   teo-m      3        12   50     104768         44      0.000         22         22
adrestia   teo-m      4        12   50     104388         18      0.000         16          2
adrestia   teo-1      0        12   50     104152         26      0.000         15         11
adrestia   teo-1      1        12   50     103556         12      0.000          9          3
adrestia   teo-1      2        11   38     104202         36      0.000         24         12
adrestia   teo-1      3        12   50     104014         25      0.000         17          8
adrestia   teo-1      4        11   38     103388         12      0.000         11          1
adrestia   teo-2      0        12   50     103492         25      0.000         12         13
adrestia   teo-2      1        12   50     103924         29      0.000         17         12
adrestia   teo-2      2        12   50     103674         19      0.000         13          6
adrestia   teo-2      3        12   50     104464         41      0.000         28         13
adrestia   teo-2      4        12   50     103758         16      0.000          8          8
adrestia   teo-3      0        12   50     103984         25      0.000         12         13
adrestia   teo-3      1        11   38     103556         23      0.000         14          9
adrestia   teo-3      2        12   50     104088         22      0.000         17          5
adrestia   teo-3      3        12   50     104430         48      0.000         26         22
adrestia   teo-3      4        12   50     103968         26      0.000         18          8
adrestia   teo-4      0        12   50     103924         19      0.000         14          5
adrestia   teo-4      1         8    0     103228         14      0.000         10          4
adrestia   teo-4      2        12   50     104124         15      0.000         10          5
adrestia   teo-4      3        12   50     104472         22      0.000         16          6
adrestia   teo-4      4        12   50     103554         30      0.000         16         14
adrestia   teo-6-6    0        12   50     102832         61      0.001         51         10
adrestia   teo-6-6    1        12   50     103136         52      0.001         38         14
adrestia   teo-6-6    2        12   50     102882         37      0.000         29          8
adrestia   teo-6-6    3        12   50     103102         51      0.000         40         11
adrestia   teo-6-6    4        12   50     103260         60      0.001         43         17
adrestia   teo-6-12   0        12   50     112320          0      0.000         43         17
adrestia   teo-6-12   1        12   50     114412          0      0.000         43         17
adrestia   teo-6-12   2        11   38     112220          0      0.000         43         17
adrestia   teo-6-12   3        12   50     112028          0      0.000         43         17
adrestia   teo-6-12   4        12   50     112750          0      0.000         43         17

