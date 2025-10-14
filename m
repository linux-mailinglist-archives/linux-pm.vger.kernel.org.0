Return-Path: <linux-pm+bounces-36063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF4BD9279
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A45354384F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67663101C5;
	Tue, 14 Oct 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt2jFhMW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E023101BC
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442951; cv=none; b=sxvpAt4r1NISOjNkti9cGSbRYo+9yoff7JdFK96+vv3DtjScDEqaanrGb49508oJUpZroDnfc8tcnuD5x8kuimUV5Xk2zs6AfN3h2Cb85y06RocsHVWvsM3q1RXUQFOqezD06gdraq1MMVGcn3kWuCHmrETRkyjSr/W0E/xCWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442951; c=relaxed/simple;
	bh=MFUsM3mmUddsmCIgma7TWfOh2WO5etYk78eABm4xIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs3a6FY9SGlUsAfG6+PaU2q3N1koREgQTqEWEimAgqoXSHmywYObBqWo1GWhzXHWqNPSFJYh05UUCUyL9E3MjYwWklXBjSvkVqVlC7Q0LXZ770K2bvuVKT1ETtqWdKQ6TbcsIQA0zxye1iz9CRSJIpjDssPMRwFF8FJPHrbDsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qt2jFhMW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2664894a12.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760442949; x=1761047749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUWv3iFGby71Sbc2/gqG/LkxyYuqIJ520wcb0ZuDVQo=;
        b=Qt2jFhMW/HIScRq/JuKsJ7Jxq4ADJW0ovZMNtIMSE+gGtcnBZ0JlWCyZcNlIQMmWlf
         rwxGcdHGQ9Ak6zN3B9mK7B5Hhi0LcjmWwD5jqeCwBHeUQ2XBWbaJwykBYknh+MJJE/Fp
         IW5Cwz0G7hIXaJhRUb3Fxk3kPzbwZnW6xTFTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442949; x=1761047749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUWv3iFGby71Sbc2/gqG/LkxyYuqIJ520wcb0ZuDVQo=;
        b=TCEJmWkrj6uN+0LGoq+bnVtAeyTR4wBwGicjiOEavgag7/q8Qh5SNxknSUuxq64Jy5
         BevcP51iOnkETDoqX10CiAD5uDVnrCU7lBE+9f3L8hgkkc55ey63LsN5/AE6hglmYpsl
         MJK+RAjkKClhuiTijC+H2dfHKNTNN+dRjA7tkd0Yly3St4v56nnued7nSmlByN+psfOZ
         mDa+rg/qDpC/MTmaV0L/fErMPRlA+ImXliPRfV8OrdM1Y7brs79uXBevVBhBzbW/89DY
         gQKq4LplXmxbfgYzy/Fr91johjmms9D0GLArfskBpnGQUisqHcLYa8W7d8DNGlCrytxu
         LTgg==
X-Forwarded-Encrypted: i=1; AJvYcCVf72tjBOCrzLn9mcPJ2sjjFjMb4BWajhTYqdsv7l6vJ9MMZYeg1SdrUnOVxp4AaogyTvgg4FI1RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqMIYL6jkffUCeLN+4Up/nJDWrYSeE/uS2ETJFn6T/sLE9LE+
	R7mwtRRkryYtK6BOlAcdijkwUHSrVfEMjFwhFhaRvuPsYwBVNhub0HET9EyZaQ8olg==
X-Gm-Gg: ASbGnctiKpOQiUegHxFO9g5rvr0XDzMDxe5yNa5qSZVvasEatlfzbImrOv5Kz7X5KaX
	qKEArrLKZNHX+Vn0HroB73vVdkOX1nmVv4d6ae8nrZ8MeK+PnT0CjphHNDCAlHtNI5SB/dDxh5w
	qh3bEl78XHLW603MImu/0f1ifQQU1+Yxtvk1xjud/9EYbtJguoZKWUww3GdG9gP3JlOGQZyRhCq
	asOJS4ajV27NVu1hvJ8/0gNvH3Inpj85LdtO5shM0QYxE7Wf9ocxgGzRpstseEr747wzcAOdHzk
	zDR1sYtzGFF9SmuhjNbeZoJyaY1z5aXoSFPpFL4ejXSSPFwEopNez9dB4WdZeuqJ7CLf5sfSbUA
	KEFk+5Sz2qGC2KxlqsXoOjz/Y5RQgd3/Vn7IFg6843RU=
X-Google-Smtp-Source: AGHT+IHSWiV+UqND31XztrNF/fQmnceWj5dUupJX0uR57X1bdjpStC4yA/dXYoqtASXEQoQSQJEQFw==
X-Received: by 2002:a17:902:e54b:b0:258:c13d:9b1a with SMTP id d9443c01a7336-290272dcdaemr330765155ad.41.1760442948635;
        Tue, 14 Oct 2025 04:55:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de7871sm162574375ad.16.2025.10.14.04.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:55:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:55:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="57jnztgduo6ucqxa"
Content-Disposition: inline
In-Reply-To: <8da42386-282e-4f97-af93-4715ae206361@arm.com>


--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On (25/10/14 11:25), Christian Loehle wrote:
> On 10/14/25 11:23, Sergey Senozhatsky wrote:
> > On (25/10/14 10:50), Christian Loehle wrote:
> >>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> >>> invalid recent intervals data") doesn't address the problems we are
> >>> observing.  Revert seems to be bringing performance metrics back to
> >>> pre-regression levels.
> >>
> >> Any details would be much appreciated.
> >> How do the idle state usages differ with and without
> >> "cpuidle: menu: Avoid discarding useful information"?
> >> What do the idle states look like in your platform?
> > 
> > Sure, I can run tests.  How do I get the numbers/stats
> > that you are asking for?
> 
> Ideally just dump
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> before and after the test.

OK, got some data for you.  The terminology being used here is as follows:

- 6.1-base
  is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding useful information"

- 6.1-base-fixup
  is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governors:
  menu: Avoid using invalid recent intervals data" cherry-pick

- 6.1-revert
  is 6.1 stable with a9edb700846 reverted (and no fixup commit, obviously)

Just to show the scale of regression, results of some of the benchmarks:

  6.1-base:		84.5
  6.1-base-fixup:	76.5
  6.1-revert:		59.5

  (lower is better, 6.1-revert has the same results as previous stable
  kernels).

Please find  /sys/devices/system/cpu/cpu*/cpuidle/state*/* dumps
attached (6 files).

The cpuidle/state*/* directory structure is as follows (NOTE: dumps
don't contain s2idle subdirs):

/sys/devices/system/cpu/cpu1/cpuidle/
|-- state0
|   |-- above
|   |-- below
|   |-- default_status
|   |-- desc
|   |-- disable
|   |-- latency
|   |-- name
|   |-- power
|   |-- rejected
|   |-- residency
|   |-- time
|   `-- usage
|-- state1
|   |-- above
|   |-- below
|   |-- default_status
|   |-- desc
|   |-- disable
|   |-- latency
|   |-- name
|   |-- power
|   |-- rejected
|   |-- residency
|   |-- s2idle
|   |   |-- time
|   |   `-- usage
|   |-- time
|   `-- usage
|-- state2
|   |-- above
|   |-- below
|   |-- default_status
|   |-- desc
|   |-- disable
|   |-- latency
|   |-- name
|   |-- power
|   |-- rejected
|   |-- residency
|   |-- s2idle
|   |   |-- time
|   |   `-- usage
|   |-- time
|   `-- usage
`-- state3
    |-- above
    |-- below
    |-- default_status
    |-- desc
    |-- disable
    |-- latency
    |-- name
    |-- power
    |-- rejected
    |-- residency
    |-- s2idle
    |   |-- time
    |   `-- usage
    |-- time
    `-- usage

Hope this helps.

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-base-after-test"

0
6290
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
202367
6897
993
74929
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
191847713
764099
71722
151
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
149341875
200291
127362
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
541976622
177665
0
5451
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
190922
5829
958
66733
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
177872430
750675
65666
114
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
142974450
189705
132455
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
564705824
185014
0
6049
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
198964
6392
1065
74400
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
198249007
834971
75131
80
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
150744820
201077
160850
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
524904977
216304
0
5425
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
170755
5725
918
67471
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
175937821
711612
62239
125
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
141196601
184986
124303
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
567330625
178220

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-base-before-test"

0
1088
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
56332
1095
16
699
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
2701663
19616
699
5
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
1752251
2211
2398
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
45107703
4427
0
1137
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
52209
1152
29
541
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
2868784
17342
620
2
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
1813300
2181
2245
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
44950188
4402
0
596
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
28250
598
44
855
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
3291276
17545
741
6
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
2245425
2570
3882
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
43040364
7244
0
548
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
26334
553
29
825
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
2741500
13132
593
4
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
1661517
2068
2021
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
45328304
4276

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-base-fixup-after-test"

0
5622
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
214428
5842
1092
68073
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
181308931
749748
66083
76
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
141979962
189347
126079
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
591520177
179133
0
5584
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
192643
5890
1060
59709
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
167257109
736458
59775
90
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
131493187
173952
132636
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
610763314
186438
0
5158
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
166999
5599
1118
65134
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
183770715
815437
67570
231
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
141702864
185642
153923
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
566152535
212196
0
4503
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
162421
4691
1082
60230
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
164979305
711633
58288
69
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
133851510
175178
124831
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
622333109
180035

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-base-fixup-before-test"

0
1404
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
70772
1415
40
1141
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
3929597
21223
805
27
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
2397281
2650
2854
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
55995957
5133
0
1291
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
61527
1296
36
717
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
3418438
21543
681
23
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
1824754
2169
2069
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
55967984
4116
0
740
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
34892
749
36
986
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
3480340
19501
722
24
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
2081421
2427
3127
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
52930672
6478
0
877
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
40376
886
40
922
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
3128952
14648
685
28
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
1810975
2150
1922
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
57628110
4045

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-revert-after-test"

0
5553
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
203089
5705
1175
52097
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
158368245
698746
96141
132
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
144897039
217063
240214
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
658034398
304378
0
4685
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
165393
5005
1061
36293
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
127609773
617707
82647
45
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
130285693
193009
235242
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
697297998
302515
0
4881
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
176017
5187
1066
38482
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
139032412
680004
92532
118
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
139225500
205414
278284
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
676711855
349678
0
4195
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
141494
4691
994
38463
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
129367024
606975
77981
164
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
131118949
188932
224524
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
710862747
294570

--57jnztgduo6ucqxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.1-revert-before-test"

0
1556
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
80877
1564
64
5929
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
13453935
50505
8267
6
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
11884260
18354
23514
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
39687648
27556
0
1156
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
52200
1169
49
2475
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
7112506
34469
4620
9
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
6924734
10532
17523
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
40831690
21574
0
875
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
44128
886
33
3029
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
7847523
33257
4641
9
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
8436592
11907
22914
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
46892106
27811
0
872
enabled
CPUIDLE CORE POLL IDLE
0
0
POLL
4294967295
0
0
39337
877
41
3402
enabled
ACPI FFH MWAIT 0x0
0
1
C1_ACPI
0
0
1
8340025
32610
4316
8
enabled
ACPI FFH MWAIT 0x33
0
253
C2_ACPI
0
0
759
9335908
12692
19002
0
enabled
ACPI FFH MWAIT 0x60
0
1048
C3_ACPI
0
0
3144
47793881
23941

--57jnztgduo6ucqxa--

