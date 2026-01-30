Return-Path: <linux-pm+bounces-41799-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKUoNIsGfWmpPwIAu9opvQ
	(envelope-from <linux-pm+bounces-41799-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 20:29:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05BBE23E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CAE300CE66
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35C388860;
	Fri, 30 Jan 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKIOiVmF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C963876D2
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801351; cv=none; b=FINMjbzlwzpd9MiQ/eofT3ep8GXUuGJIVi6Uuq5U0pp/hJLpoF9Jz+UTsb55br6lz3usYOGqpK1LaIoUdq2oKOWX5XsMwitzZNYNkHfcBPHUK4w6CveR3Y1JG0SlmRfd4IxfZGwiERmktnEZZZ3xPHgZzKkqYpNo4qLFU/SWxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801351; c=relaxed/simple;
	bh=WzeItp1DRTUqKp/9e7w6c4g+FgDenYMP0iSbO1++jDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRBqmQEb/uDPXNQFOAdaaEYjzQUoRfoZolggG6iTnAFfaaeL1J16byAXf/A1ImS9oP8CwMYS/J4v49p7kj9Mbl27sh86tOjQzwLvVygxzmBu1kMCrfbWcisGypmZpoWUd3v1tn0fndMuK7nWKO3ym8MoDljlL6oEQATWXaL9eIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKIOiVmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB47AC16AAE
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801350;
	bh=WzeItp1DRTUqKp/9e7w6c4g+FgDenYMP0iSbO1++jDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKIOiVmF1iy5DeHhlh3x6VxORiXn/ikYNS5cUAhTgThS/PxBeaTdSdmskvpoMag1M
	 BzclYUsHaccqu3dWKquhe78+xt4cAcCQHk4Yx7DigdJMH+KrfDLBfCqQHa8rQSuuZs
	 4OJizIfUAqcAOiFnqk6EZolDbUu95fE8IJ5BpJNsaGeQta9cCRygtUTm9eV/Xfn+N/
	 j5ql8AKdf8BNo1sr277PYAcVBPBNn4NFy7RGISnxAsGkS1rlDtfJR/N6CsuJS6QVQf
	 pa1q8cPSpljPFaiG3G+d2sZAb3jufMP9NqmDgNa9pesCQF0Fn5dnt6JdZLE4cSl2OH
	 H0Xcw4hpLv0hA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfdf0c8908so1511025a34.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:29:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg18UokVxjv4+rliZSHt+MAT0EgV8FYDh5ZYkUJlrIdxmTn9fctPp9mjKbQZbujYuUtuxgFpsjMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYJhApLduCOPjQnk9Cebm6pqqIWI/YDMvC6ji10LzVWk/MTm4
	uDboykGcVlL5mn+wSlYBOqkxHJCaCXQaNNBj4MQN9CGfbEaxn6oxB2Eou+ThkXK32QewnUmoDXJ
	3n4bcF4KcaGEwVO8r4gC30mnuiU2fopM=
X-Received: by 2002:a05:6820:1f05:b0:663:23a:caf4 with SMTP id
 006d021491bc7-6630f0317cfmr1690473eaf.2.1769801349722; Fri, 30 Jan 2026
 11:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com> <003e01dc9013$e3bc5060$ab34f120$@telus.net>
 <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net> <002601dc916e$6acbe650$4063b2f0$@telus.net>
In-Reply-To: <002601dc916e$6acbe650$4063b2f0$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 20:28:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
X-Gm-Features: AZwV_Qi4PUwPqvSQzVb5jeIQp7G5TA3-oxr-HbTXhdXTmf3v7XpGoaPT3LFf4ZQ
Message-ID: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Doug Smythies <dsmythies@telus.net>, Christian Loehle <christian.loehle@arm.com>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41799-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[urldefense.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,urldefense.com:url]
X-Rspamd-Queue-Id: 2C05BBE23E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:27=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
>
> On 2026.01.28 15:53 Doug Smythies wrote:
> > On 2026.01.27 21:07 Doug Smythies wrote:
> >> On 2026.01.27 07:45 Harshvardhan Jha wrote:
> >>> On 08/12/25 6:17 PM, Christian Loehle wrote:
> >>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
> >>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
> >>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
> >>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
> > ... snip ...
> >
> >>>> It would be nice to get the idle states here, ideally how the states=
' usage changed
> >>>> from base to revert.
> >>>> The mentioned thread did this and should show how it can be done, bu=
t a dump of
> >>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> >>>> before and after the workload is usually fine to work with:
> >>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da4238=
6-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNx=
WEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIP=
pMt53$
> >
> >>> Apologies for the late reply, I'm attaching a tar ball which has the =
cpu
> >>> states for the test suites before and after tests. The folders with t=
he
> >>> name of the test contain two folders good-kernel and bad-kernel
> >>> containing two files having the before and after states. Please note
> >>> that different machines were used for different test suites due to
> >>> compatibility reasons. The jbb test was run using containers.
> >
> > Please provide the results of the test runs that were done for
> > the supplied before and after idle data.
> > In particular, what is the "fio" test and it results. Its idle data is =
not very revealing.
> > Is it a test I can run on my test computer?
>
> I see that I have fio installed on my test computer.
>
> >> It is a considerable amount of work to manually extract and summarize =
the data.
> >> I have only done it for the phoronix-sqlite data.
> >
> > I have done the rest now, see below.
> > I have also attached the results, in case the formatting gets screwed u=
p.
> >
> >> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting=
 to disabled.
> >> I remember seeing a Linux-pm email about why but couldn't find it just=
 now.
> >> Summary (also attached as a PNG file, in case the formatting gets mess=
ed up):
> >> The total idle entries (usage)  and time seem low to me, which is why =
the ???.
> >>
> >> phoronix-sqlite
> >>      Good Kernel: Time between samples 4 seconds (estimated and ???)
> >>              Usage   Above   Below   Above   Below
> >> state 0      220     0       218     0.00%   99.09%
> >> state 1      70212   5213    34602   7.42%   49.28%
> >> state 2      30273   5237    1806    17.30%  5.97%
> >> state 3      0       0       0       0.00%   0.00%
> >> state 4      11824   2120    0       17.93%  0.00%
> >>
> >> total                112529  12570   36626   43.72%   <<< Misses %
> >>
> >>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
> >>              Usage   Above   Below   Above   Below
> >> state 0      262     0       260     0.00%   99.24%
> >> state 1      62751   3985    35588   6.35%   56.71%
> >> state 2      24941   7896    1433    31.66%  5.75%
> >> state 3      0       0       0       0.00%   0.00%
> >> state 4      24489   11543   0       47.14%  0.00%
> >>
> >> total                112443  23424   37281   53.99%   <<< Misses %
> >>
> >> Observe 2X use of idle state 4 for the "Bad Kernel"
> >>
> >> I have a template now, and can summarize the other 40 CPU data
> >> faster, but I would have to rework the template for the 56 CPU data,
> >> and is it a 64 CPU data set at 4 idle states per CPU?
> >
> > jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
> > POLL, C1, C1E, C3 (disabled), C6
> >
> >       Good Kernel: Time between samples > 2 hours (estimated)
> >       Usage           Above           Below           Above   Below
> > state 0       297550          0               296084          0.00%   9=
9.51%
> > state 1       8062854 341043          4962635 4.23%   61.55%
> > state 2       56708358        12688379        6252051 22.37%  11.02%
> > state 3       0               0               0               0.00%   0=
.00%
> > state 4       54624476        15868752        0               29.05%  0=
.00%
> >
> > total 119693238       28898174        11510770        33.76%  <<< Misse=
s
> >
> >       Bad Kernel: Time between samples > 2 hours (estimated)
> >       Usage           Above           Below           Above   Below
> > state 0       90715           0               75134           0.00%   8=
2.82%
> > state 1       8878738 312970          6082180 3.52%   68.50%
> > state 2       12048728        2576251 603316          21.38%  5.01%
> > state 3       0               0               0               0.00%   0=
.00%
> > state 4       85999424        44723273        0               52.00%  0=
.00%
> >
> > total 107017605       47612494        6760630 50.81%  <<< Misses
> >
> > As with the previous test, observe 1.6X use of idle state 4 for the "Ba=
d Kernel"
> >
> > fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
> >
> > fio
> >       Good Kernel: Time between samples ~ 1 minute (estimated)
> >       Usage           Above   Below   Above   Below
> > state 0       3822            0       3818    0.00%   99.90%
> > state 1       148640          4406    68956   2.96%   46.39%
> > state 2       593455          45344   105675  7.64%   17.81%
> > state 3       3209648 807014  0       25.14%  0.00%
> >
> > total 3955565 856764  178449  26.17%  <<< Misses
> >
> >       Bad Kernel: Time between samples ~ 1 minute (estimated)
> >       Usage           Above   Below   Above   Below
> > state 0       916             0       756     0.00%   82.53%
> > state 1       80230           2028    42791   2.53%   53.34%
> > state 2       59231           6888    6791    11.63%  11.47%
> > state 3       2455784 564797  0       23.00%  0.00%
> >
> > total 2596161 573713  50338   24.04%  <<< Misses
> >
> > It is not clear why the number of idle entries differs so much
> > between the tests, but there is a bit of a different distribution
> > of the workload among the CPUs.
> >
> > rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to dis=
abled.
> > POLL, C1, C1E, C3 (disabled), C6
> >
> > rds-stress-test
> >       Good Kernel: Time between samples ~70 Seconds (estimated)
> >       Usage   Above   Below   Above   Below
> > state 0       1561    0       1435    0.00%   91.93%
> > state 1       13855   899     2410    6.49%   17.39%
> > state 2       467998  139254  23679   29.76%  5.06%
> > state 3       0       0       0       0.00%   0.00%
> > state 4       213132  107417  0       50.40%  0.00%
> >
> > total 696546  247570  27524   39.49%  <<< Misses
> >
> >       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
> >       Usage   Above   Below   Above   Below
> > state 0       231     0       231     0.00%   100.00%
> > state 1       5413    266     1186    4.91%   21.91%
> > state 2       54365   719     3789    1.32%   6.97%
> > state 3       0       0       0       0.00%   0.00%
> > state 4       267055  148327  0       55.54%  0.00%
> >
> > total 327064  149312  5206    47.24%  <<< Misses
> >
> > Again, differing numbers of idle entries between tests.
> > This time the load distribution between CPUs is more
> > obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
> > In the "Good" case the work is distributed over more CPUs.
> > I assume without proof, that the scheduler is deciding not to migrate
> > the next bit of work to another CPU in the one case verses the other.
>
> The above is incorrect. The CPUs involved between the "Good"
> and "Bad" tests are very similar, mainly 2 CPUs with a little of
> a 3rd and 4th. See the attached graph for more detail / clarity.
>
> All of the tests show higher usage of shallower idle states with
> the "Good" verses the "Bad", which was the expectation of the
> original patch, as has been mentioned a few times in the emails.
>
> My input is to revert the reversion.

OK, noted, thanks!

Christian, what do you think?

