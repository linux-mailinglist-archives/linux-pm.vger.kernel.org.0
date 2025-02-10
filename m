Return-Path: <linux-pm+bounces-21701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1FA2F016
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897071886CAD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516B25291D;
	Mon, 10 Feb 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uphC45ug"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7125290A;
	Mon, 10 Feb 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198649; cv=none; b=NzjycemjBmwChimD5B/irpxBQZkEZ3lnFpGkBsdZJHBB9swMcciQBNvXoW8RDupXYq8/oLgc5oVqsCHTExTFhByrgfD2EnK+ZKYaNZO2ZO5jZCREO4IL7DLFbp2UkPTBcK1QhNP1isw78CjXkDz5vlGTP+HatbPpgsg46Q+nDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198649; c=relaxed/simple;
	bh=mKztR/EOo7pcxQJIOtLoD6WsfGO+IjyNofiojLnK7fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icF0F1YuU8LtWdBERUpl8au/yoFV47WnYV5GDvVBP9U3pxy3wia0Rm4QOSh0GfyKdWdYo8r6v/SomidLEjLnP4uc9LQWeENJdSWu808IflUuy00PmE3lN7EghNQ5PTtxVIq6ECR/jJ1/PE/KIDkXXk/BdNfjU3+Atb0rKoPW6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uphC45ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF209C4CEDF;
	Mon, 10 Feb 2025 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198649;
	bh=mKztR/EOo7pcxQJIOtLoD6WsfGO+IjyNofiojLnK7fw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uphC45ug7DlL1MjXDfk5WvSxnPV45Qpkv6HAAXP9ARn2t9951B7ztDhCelEMZ8kNf
	 8KDdUQyocWRODTlanT46kiSFQlGRY+ObEnKiBqdyfkqZrk0sxzwMsKAOSwTfGexuqt
	 nCHAtvCOGlgLvnGO8AqfqrVzkWh5DA+dxG5b9xGyIMUKN0wX1hL99FLq1OwYpVei9y
	 yE1D7OGL0/jtWD2WnjZIX4AvJ8Rj8SnNxFfyl2wAyx87dZiayOVnmU0r8dsZ1I5ew6
	 n3c6afgsI8Em2jtPpSYdd65eoaO2iyz6pbMYI5i/MSelepA1RJ+EyB09pPy5NzlSVA
	 UG/QV2Yc65LqQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3c0abde9eso55083b6e.1;
        Mon, 10 Feb 2025 06:44:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaNk92s6dNLmEuoJeFcxGaVofZMXBf9lyB9d3f5SkEILYL80ozBou91fVidb7WpJFnm4lig+VxUtM=@vger.kernel.org, AJvYcCW+wpFAwPMqkL55LUjLfProMBF0QphqUv8LGkKK5BSHg6ldenMV4n5+tSnw/yzRX0BmeYE71W0p8mq29Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFj+Fprq7fctplDPLzabq8bG/YjuBEOPyYAEdI7Q8+9SeKdRWl
	xwxlkPBgT5y3JyzNHJUE1OWTBx3jDr0HmBlgX99q09kIuyz+E8JAYGQTPgA+Hx9zJiwBh6y0dGk
	OBADAdXtD8GM0K8uCWF8fpDmKi0Q=
X-Google-Smtp-Source: AGHT+IGnEAsEWdNIV7yAvXEXHa/IGcp6KlYQWYt3AZjv01jrBooHJmUQLH5azqks/wugzO7+mtXa/IHhTJLUHCZtY6s=
X-Received: by 2002:a05:6808:384e:b0:3eb:575e:3ecb with SMTP id
 5614622812f47-3f392314b94mr9453465b6e.19.1739198648102; Mon, 10 Feb 2025
 06:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
In-Reply-To: <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Feb 2025 15:43:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxx-9AVJPJRRVPU8kx4kt9pgr6NhDuhEU_RHj=tCJQvw@mail.gmail.com>
X-Gm-Features: AWEUYZlC9ftfUBiYvfeV6tI57tuOj45FtlCM67xMecxlG6slB6rX0CEn0pPRD-E
Message-ID: <CAJZ5v0hxx-9AVJPJRRVPU8kx4kt9pgr6NhDuhEU_RHj=tCJQvw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 3:15=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/6/25 14:21, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This work had been triggered by a report that commit 0611a640e60a ("eve=
ntpoll:
> > prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metr=
ic of
> > the SPECjbb 2015 benchmark [1] to drop by around 50% even though it gen=
erally
> > reduced kernel overhead.  Indeed, it was found during further investiga=
tion
> > that the total interrupt rate while running the SPECjbb workload had fa=
llen as
> > a result of that commit by 55% and the local timer interrupt rate had f=
allen by
> > almost 80%.
> >
> > That turned out to cause the menu cpuidle governor to select the deepes=
t idle
> > state supplied by the cpuidle driver (intel_idle) much more often which=
 added
> > significantly more idle state latency to the workload and that led to t=
he
> > decrease of the critical-jOPS score.
> >
> > Interestingly enough, this problem was not visible when the teo cpuidle
> > governor was used instead of menu, so it appeared to be specific to the
> > latter.  CPU wakeup event statistics collected while running the worklo=
ad
> > indicated that the menu governor was effectively ignoring non-timer wak=
eup
> > information and all of its idle state selection decisions appeared to b=
e
> > based on timer wakeups only.  Thus, it appeared that the reduction of t=
he
> > local timer interrupt rate caused the governor to predict a idle durati=
on
> > much more often while running the workload and the deepest idle state w=
as
> > selected significantly more often as a result of that.
> >
> > A subsequent inspection of the get_typical_interval() function in the m=
enu
> > governor indicated that it might return UINT_MAX too often which then c=
aused
> > the governor's decisions to be based entirely on information related to=
 timers.
> >
> > Generally speaking, UINT_MAX is returned by get_typical_interval() if i=
t
> > cannot make a prediction based on the most recent idle intervals data w=
ith
> > sufficiently high confidence, but at least in some cases this means tha=
t
> > useful information is not taken into account at all which may lead to
> > significant idle state selection mistakes.  Moreover, this is not reall=
y
> > unlikely to happen.
> >
> > One issue with get_typical_interval() is that, when it eliminates outli=
ers from
> > the sample set in an attempt to reduce the standard deviation (and so i=
mprove
> > the prediction confidence), it does that by dropping high-end samples o=
nly,
> > while samples at the low end of the set are retained.  However, the sam=
ples
> > at the low end very well may be the outliers and they should be elimina=
ted
> > from the sample set instead of the high-end samples.  Accordingly, the
> > likelihood of making a meaningful idle duration prediction can be impro=
ved
> > by making it also eliminate low-end samples if they are farther from th=
e
> > average than high-end samples.  This is done in patch [4/5].
> >
> > Another issue is that get_typical_interval() gives up after eliminating=
 1/4
> > of the samples if the standard deviation is still not as low as desired=
 (within
> > 1/6 of the average or within 20 us if the average is close to 0), but t=
he
> > remaining samples in the set still represent useful information at that=
 point
> > and discarding them altogether may lead to suboptimal idle state select=
ion.
> >
> > For instance, the largest idle duration value in the get_typical_interv=
al()
> > data set is the maximum idle duration observed recently and it is likel=
y that
> > the upcoming idle duration will not exceed it.  Therefore, in the absen=
ce of
> > a better choice, this value can be used as an upper bound on the target
> > residency of the idle state to select.  Patch [5/5] works along these l=
ines,
> > but it takes the maximum data point remaining after the elimination of
> > outliers.
> >
> > The first two patches in the series are straightforward cleanups (in fa=
ct,
> > the first patch is kind of reversed by patch [4/5], but it is there bec=
ause
> > it can be applied without the latter) and patch [3/5] is a cosmetic cha=
nge
> > made in preparation for the subsequent ones.
> >
> > This series turns out to restore the SPECjbb critical-jOPS metric on af=
fected
> > systems to the level from before commit 0611a640e60a and it also happen=
s to
> > increase its max-jOPS metric by around 3%.
> >
> > For easier reference/testing it is present in the git branch at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dexperimental/menu
> >
> > based on the cpuidle material that went into 6.14-rc1.
> >
> > If possible, please let me know if it works for you.
> >
> > Thanks!
> >
> >
> > [1] Link: https://www.spec.org/jbb2015/
>
> 5/5 shows significant IO workload improvements (the shorter wakeup scenar=
io is
> much more likely to be picked up now).
> I don't see a significant regression in idle misses so far, I'll try Andr=
oid
> backports soon and some other system.

Sounds good, thanks!

> Here's a full dump, sorry it's from a different system (rk3588, only two =
idle
> states), apparently eth networking is broken on 6.14-rc1 now on rk3399 :(
>
> For dm-delay 51ms (dm-slow) the command is (8 CPUs)
> fio --minimal --time_based --group_reporting --name=3Dfiotest --filename=
=3D/dev/mapper/dm-slow --runtime=3D30s --numjobs=3D16 --rw=3Drandread --bs=
=3D4k --ioengine=3Dpsync --iodepth=3D1 --direct=3D1
> For the rest:
> fio --minimal --time_based --name=3Dfiotest --filename=3D/dev/mmcblk1 --r=
untime=3D30s --rw=3Drandread --bs=3D4k --ioengine=3Dpsync --iodepth=3D1 --d=
irect=3D1

Thanks for the data!

Do I understand correctly that menu-X is menu with patches [1-X/5]
applied?  And what's menu-m?

> device   gov     iter    iops    idles   idle_misses     idle_miss_ratio =
        belows  aboves
> mapper/dm-slow  menu    0       307     99648   318     0.003   318     0
> mapper/dm-slow  menu    1       307     100948  389     0.004   389     0
> mapper/dm-slow  menu    2       307     99512   380     0.004   380     0
> mapper/dm-slow  menu    3       307     99212   307     0.003   307     0
> mapper/dm-slow  menu    4       307     100156  343     0.003   343     0
> mapper/dm-slow  menu-1  0       307     97434   260     0.003   260     0
> mapper/dm-slow  menu-1  1       307     94628   324     0.003   324     0
> mapper/dm-slow  menu-1  2       307     98004   248     0.003   248     0
> mapper/dm-slow  menu-1  3       307     97524   263     0.003   263     0
> mapper/dm-slow  menu-1  4       307     97048   304     0.003   304     0
> mapper/dm-slow  menu-2  0       307     98340   376     0.004   376     0
> mapper/dm-slow  menu-2  1       307     96246   275     0.003   275     0
> mapper/dm-slow  menu-2  2       307     96456   317     0.003   317     0
> mapper/dm-slow  menu-2  3       307     100054  268     0.003   268     0
> mapper/dm-slow  menu-2  4       307     93378   288     0.003   288     0
> mapper/dm-slow  menu-3  0       307     95140   303     0.003   303     0
> mapper/dm-slow  menu-3  1       307     95858   318     0.003   318     0
> mapper/dm-slow  menu-3  2       307     100528  302     0.003   302     0
> mapper/dm-slow  menu-3  3       307     98274   311     0.003   311     0
> mapper/dm-slow  menu-3  4       307     98428   327     0.003   327     0
> mapper/dm-slow  menu-4  0       307     100340  304     0.003   304     0
> mapper/dm-slow  menu-4  1       307     101628  359     0.004   359     0
> mapper/dm-slow  menu-4  2       307     100624  281     0.003   281     0
> mapper/dm-slow  menu-4  3       307     99824   340     0.003   340     0
> mapper/dm-slow  menu-4  4       307     98318   290     0.003   290     0
> mapper/dm-slow  menu-5  0       307     96842   310     0.003   310     0
> mapper/dm-slow  menu-5  1       307     98884   271     0.003   271     0
> mapper/dm-slow  menu-5  2       307     99706   259     0.003   259     0
> mapper/dm-slow  menu-5  3       307     93096   270     0.003   270     0
> mapper/dm-slow  menu-5  4       307     101590  333     0.003   333     0
> mapper/dm-slow  menu-m  0       307     94270   297     0.003   297     0
> mapper/dm-slow  menu-m  1       307     99820   355     0.004   355     0
> mapper/dm-slow  menu-m  2       307     99284   313     0.003   313     0
> mapper/dm-slow  menu-m  3       307     99320   288     0.003   288     0
> mapper/dm-slow  menu-m  4       307     99666   269     0.003   269     0
> mmcblk1         menu    0       818     227246  32716   0.144   32716   0
> mmcblk1         menu    1       818     252552  33582   0.133   33582   0
> mmcblk1         menu    2       825     255822  31958   0.125   31958   0
> mmcblk1         menu    3       822     255814  33374   0.130   33374   0
> mmcblk1         menu    4       822     253200  33310   0.132   33310   0
> mmcblk1         menu-1  0       822     254768  33545   0.132   33545   0
> mmcblk1         menu-1  1       819     249476  33289   0.133   33289   0
> mmcblk1         menu-1  2       823     256152  32838   0.128   32838   0
> mmcblk1         menu-1  3       824     231098  31120   0.135   31120   0
> mmcblk1         menu-1  4       820     254590  33189   0.130   33189   0
> mmcblk1         menu-2  0       824     256084  32927   0.129   32927   0
> mmcblk1         menu-2  1       806     240166  33672   0.140   33672   0
> mmcblk1         menu-2  2       808     253178  33963   0.134   33963   0
> mmcblk1         menu-2  3       822     240628  32860   0.137   32860   0
> mmcblk1         menu-2  4       811     251522  33478   0.133   33478   0
> mmcblk1         menu-3  0       810     251914  32477   0.129   32477   0
> mmcblk1         menu-3  1       811     253324  32344   0.128   32344   0
> mmcblk1         menu-3  2       826     239634  31478   0.131   31478   0
> mmcblk1         menu-3  3       811     252462  33810   0.134   33810   0
> mmcblk1         menu-3  4       806     231730  33646   0.145   33646   0
> mmcblk1         menu-4  0       826     231986  32301   0.139   32301   0
> mmcblk1         menu-4  1       821     256988  34290   0.133   34290   0
> mmcblk1         menu-4  2       805     247456  35092   0.142   35092   0
> mmcblk1         menu-4  3       807     255072  35291   0.138   35291   0
> mmcblk1         menu-4  4       808     255076  35222   0.138   35222   0
> mmcblk1         menu-5  0       861     308822  26267   0.085   26267   0
> mmcblk1         menu-5  1       835     288153  26496   0.092   26496   0
> mmcblk1         menu-5  2       841     304148  26916   0.088   26916   0
> mmcblk1         menu-5  3       858     304838  26347   0.086   26347   0
> mmcblk1         menu-5  4       859     303370  26090   0.086   26090   0
> mmcblk1         menu-m  0       811     243486  33215   0.136   33215   0
> mmcblk1         menu-m  1       827     256902  32863   0.128   32863   0
> mmcblk1         menu-m  2       807     249032  34080   0.137   34080   0
> mmcblk1         menu-m  3       809     253537  33718   0.133   33718   0
> mmcblk1         menu-m  4       824     241996  32842   0.136   32842   0
> mmcblk1         teo     0       874     346720  18326   0.053   18326   0
> mmcblk1         teo     1       889     350712  19364   0.055   19364   0
> mmcblk1         teo     2       874     341195  19004   0.056   19004   0
> mmcblk1         teo     3       870     343718  18770   0.055   18770   0
> mmcblk1         teo     4       871     321152  18415   0.057   18415   0
> nvme0n1         menu    0       11546   819014  110717  0.135   110717  0
> nvme0n1         menu    1       10507   745534  86297   0.116   86297   0
> nvme0n1         menu    2       11758   829030  110667  0.133   110667  0
> nvme0n1         menu    3       10762   768898  93655   0.122   93655   0
> nvme0n1         menu    4       11719   820536  110456  0.135   110456  0
> nvme0n1         menu-1  0       11409   811374  111285  0.137   111285  0
> nvme0n1         menu-1  1       11432   805208  108621  0.135   108621  0
> nvme0n1         menu-1  2       11154   781534  100566  0.129   100566  0
> nvme0n1         menu-1  3       10180   724944  73523   0.101   73523   0
> nvme0n1         menu-1  4       11667   827804  110505  0.133   110505  0
> nvme0n1         menu-2  0       11091   791998  105824  0.134   105824  0
> nvme0n1         menu-2  1       10664   748122  90282   0.121   90282   0
> nvme0n1         menu-2  2       10921   773806  95668   0.124   95668   0
> nvme0n1         menu-2  3       11445   807918  112475  0.139   112475  0
> nvme0n1         menu-2  4       10629   761546  90181   0.118   90181   0
> nvme0n1         menu-3  0       10330   723824  74813   0.103   74813   0
> nvme0n1         menu-3  1       10242   717762  74187   0.103   74187   0
> nvme0n1         menu-3  2       10579   754108  86841   0.115   86841   0
> nvme0n1         menu-3  3       10161   730416  76722   0.105   76722   0
> nvme0n1         menu-3  4       11665   820052  112621  0.137   112621  0
> nvme0n1         menu-4  0       11279   789456  106411  0.135   106411  0
> nvme0n1         menu-4  1       11095   766714  98036   0.128   98036   0
> nvme0n1         menu-4  2       11003   786088  98979   0.126   98979   0
> nvme0n1         menu-4  3       10371   746978  77039   0.103   77039   0
> nvme0n1         menu-4  4       10761   770218  89958   0.117   89958   0
> nvme0n1         menu-5  0       13243   926672  514     0.001   514     0
> nvme0n1         menu-5  1       14235   985852  1054    0.001   1054    0
> nvme0n1         menu-5  2       13032   911560  506     0.001   506     0
> nvme0n1         menu-5  3       13074   917252  691     0.001   691     0
> nvme0n1         menu-5  4       13361   933126  466     0.000   466     0
> nvme0n1         menu-m  0       10290   739468  73692   0.100   73692   0
> nvme0n1         menu-m  1       10647   763144  80430   0.105   80430   0
> nvme0n1         menu-m  2       11067   790362  98525   0.125   98525   0
> nvme0n1         menu-m  3       11337   806888  102446  0.127   102446  0
> nvme0n1         menu-m  4       11519   818128  110233  0.135   110233  0
> nvme0n1         teo     0       14267   994532  273     0.000   273     0
> nvme0n1         teo     1       13857   965726  395     0.000   395     0
> nvme0n1         teo     2       12762   892900  311     0.000   311     0
> nvme0n1         teo     3       13056   900172  269     0.000   269     0
> nvme0n1         teo     4       13687   956048  240     0.000   240     0
> sda     menu    0       1943    1044428         162298  0.155   162298  0
> sda     menu    1       1601    860152  232733  0.271   232733  0
> sda     menu    2       1947    1089550         154879  0.142   154879  0
> sda     menu    3       1917    992278  146316  0.147   146316  0
> sda     menu    4       1706    947224  257686  0.272   257686  0
> sda     menu-1  0       1981    1109204         174590  0.157   174590  0
> sda     menu-1  1       1778    989142  271685  0.275   271685  0
> sda     menu-1  2       1759    955310  252735  0.265   252735  0
> sda     menu-1  3       1818    985389  180365  0.183   180365  0
> sda     menu-1  4       1782    915060  247016  0.270   247016  0
> sda     menu-2  0       1877    959734  181691  0.189   181691  0
> sda     menu-2  1       1718    961724  262950  0.273   262950  0
> sda     menu-2  2       1751    949092  259223  0.273   259223  0
> sda     menu-2  3       1808    1011822         211016  0.209   211016  0
> sda     menu-2  4       1734    959348  261769  0.273   261769  0
> sda     menu-3  0       1723    952826  260493  0.273   260493  0
> sda     menu-3  1       1718    931974  254462  0.273   254462  0
> sda     menu-3  2       1773    984232  239335  0.243   239335  0
> sda     menu-3  3       1741    969477  265131  0.273   265131  0
> sda     menu-3  4       1735    970372  263907  0.272   263907  0
> sda     menu-4  0       1911    1030290         170538  0.166   170538  0
> sda     menu-4  1       1769    972168  233029  0.240   233029  0
> sda     menu-4  2       1737    969896  260880  0.269   260880  0
> sda     menu-4  3       1738    941298  253874  0.270   253874  0
> sda     menu-4  4       1701    953710  258250  0.271   258250  0
> sda     menu-5  0       2463    1349556         26158   0.019   26158   0
> sda     menu-5  1       2359    1344306         80343   0.060   80343   0
> sda     menu-5  2       2280    1306554         115670  0.089   115670  0
> sda     menu-5  3       2573    1420702         4765    0.003   4765    0
> sda     menu-5  4       2348    1355996         70428   0.052   70428   0
> sda     menu-m  0       1738    962150  261205  0.271   261205  0
> sda     menu-m  1       1667    922214  238208  0.258   238208  0
> sda     menu-m  2       1696    911352  255364  0.280   255364  0
> sda     menu-m  3       1840    1006556         193333  0.192   193333  0
> sda     menu-m  4       1681    919693  251029  0.273   251029  0
> sda     teo     0       2503    1427634         25997   0.018   25997   0
> sda     teo     1       2424    1401434         35228   0.025   35228   0
> sda     teo     2       2527    1454382         27546   0.019   27546   0
> sda     teo     3       2481    1430128         16678   0.012   16678   0
> sda     teo     4       2589    1481254         13389   0.009   13389   0
> nullb0  menu    0       337827  88502   200     0.002   200     0
> nullb0  menu    1       337833  87476   188     0.002   188     0
> nullb0  menu    2       336378  88862   92      0.001   92      0
> nullb0  menu    3       336022  86174   188     0.002   188     0
> nullb0  menu    4       335158  87880   156     0.002   156     0
> nullb0  menu-1  0       334663  89150   199     0.002   199     0
> nullb0  menu-1  1       338526  88184   111     0.001   111     0
> nullb0  menu-1  2       336671  89210   211     0.002   211     0
> nullb0  menu-1  3       337454  82408   198     0.002   198     0
> nullb0  menu-1  4       338256  86994   118     0.001   118     0
> nullb0  menu-2  0       336636  82202   165     0.002   165     0
> nullb0  menu-2  1       337580  77918   171     0.002   171     0
> nullb0  menu-2  2       336260  89198   226     0.003   226     0
> nullb0  menu-2  3       338440  85444   215     0.003   215     0
> nullb0  menu-2  4       333633  87244   119     0.001   119     0
> nullb0  menu-3  0       336890  88096   122     0.001   122     0
> nullb0  menu-3  1       335804  68502   79      0.001   79      0
> nullb0  menu-3  2       336863  87258   195     0.002   195     0
> nullb0  menu-3  3       337091  76452   127     0.002   127     0
> nullb0  menu-3  4       336142  80664   83      0.001   83      0
> nullb0  menu-4  0       336840  86936   128     0.001   128     0
> nullb0  menu-4  1       334498  88792   113     0.001   113     0
> nullb0  menu-4  2       336736  88542   104     0.001   104     0
> nullb0  menu-4  3       336476  64548   70      0.001   70      0
> nullb0  menu-4  4       337513  84776   107     0.001   107     0
> nullb0  menu-5  0       338498  89216   135     0.002   135     0
> nullb0  menu-5  1       335087  87424   85      0.001   85      0
> nullb0  menu-5  2       336965  75456   179     0.002   179     0
> nullb0  menu-5  3       337415  88112   114     0.001   114     0
> nullb0  menu-5  4       332365  76456   82      0.001   82      0
> nullb0  menu-m  0       337718  88018   125     0.001   125     0
> nullb0  menu-m  1       337801  86584   164     0.002   164     0
> nullb0  menu-m  2       336760  84262   102     0.001   102     0
> nullb0  menu-m  3       337524  87902   147     0.002   147     0
> nullb0  menu-m  4       333724  87916   117     0.001   117     0
> nullb0  teo     0       336215  88312   231     0.003   231     0
> nullb0  teo     1       337653  88802   266     0.003   266     0
> nullb0  teo     2       337198  87960   234     0.003   234     0
> nullb0  teo     3       338716  88516   227     0.003   227     0
> nullb0  teo     4       336334  88978   261     0.003   261     0
>

