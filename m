Return-Path: <linux-pm+bounces-42412-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEk4IQzzimnUOwAAu9opvQ
	(envelope-from <linux-pm+bounces-42412-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:57:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D49118729
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C628300BE96
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7E33C1BD;
	Tue, 10 Feb 2026 08:57:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA73375AA;
	Tue, 10 Feb 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713853; cv=none; b=bczAW0BIEdH0DqdH0YsVGhc8lWB70PMsXecOG794UHQfSsjTAWv8kvNvhZvTMBvCd1O1FpUFx9LmI9XiT6VOElHvtUVwJUw/AehzDzavI2yiMGHeFCEIJYf0AIj053wCHCpQARnqrzsGA49s/q2ikEvbzYaQH4ALPc8/7Xpa3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713853; c=relaxed/simple;
	bh=j3PmniGhuDoQ4/vEh3AHo+Nka8lVaTgFBrcLO+s8oGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRAaBFfV+51JUN00+CTpUF+ihquVZk9mR/KM3f/LbJrsNSb10wI8+FyKfmlrrycVefJr+2h/5ATqEhVKc4hDRirBercYgYGgttYp/G68tc4uxtXorYPHYx4aG1gtDJMC7k6+xd1ZVCjYtMG3RH+JmJnIUG1IDjBSB8btN0JmWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFECD339;
	Tue, 10 Feb 2026 00:57:23 -0800 (PST)
Received: from [10.1.31.20] (unknown [10.1.31.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A5D3F740;
	Tue, 10 Feb 2026 00:57:28 -0800 (PST)
Message-ID: <946c9ff1-a0cf-4faa-aeb9-405f89121b81@arm.com>
Date: Tue, 10 Feb 2026 08:57:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Doug Smythies <dsmythies@telus.net>,
 "'Rafael J. Wysocki'" <rafael@kernel.org>,
 'Harshvardhan Jha' <harshvardhan.j.jha@oracle.com>,
 'Sasha Levin' <sashal@kernel.org>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
 stable@vger.kernel.org, 'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
 <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
 <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
 <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
 <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com>
 <ioyakugzog4uecwugy4b5ysxdimvh7qtosainou37rwp5bpoks@5csx6sn7ziso>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ioyakugzog4uecwugy4b5ysxdimvh7qtosainou37rwp5bpoks@5csx6sn7ziso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-42412-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B1D49118729
X-Rspamd-Action: no action

On 2/10/26 08:02, Sergey Senozhatsky wrote:
> On (26/02/05 07:15), Christian Loehle wrote:
> [..]
>> @Doug given this is on Chromebooks base=84.5 and revert=59.5 doesn't necessarily mean
>> 29.6% decrease in system performance in a traditional throughput sense.
>> The "benchmark" might me measuring dropped frames, user input latency or what have you.
>> Nonetheless @Sergey do feel free to expand.
> 
> I'm not on the performance team and I don't define those metrics, so
> I can't really comment.  But frame drops during Google Docs scrolling,
> for instance, or typing is a user visible regression, that people tend
> to notice.

Yeah I guess that was my point already, i.e. it isn't implausible that
e.g. a frequency reduction from 2.2GHz to 2.0GHz (-10%) might result in
double the number of dropped frames (= score reduction of 50%).
Everything just an example but don't be thrown off by the 29.6% reduction in
score and expect to go looking for -29.6% cpu frequency (like you would expect
for many purely cpubound benchmarks).

