Return-Path: <linux-pm+bounces-1006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAC80F5C0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EBC1F217AC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CDD7F551;
	Tue, 12 Dec 2023 18:50:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4AEA10E;
	Tue, 12 Dec 2023 10:50:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9FBB1FB;
	Tue, 12 Dec 2023 10:50:57 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301033F762;
	Tue, 12 Dec 2023 10:50:08 -0800 (PST)
Message-ID: <c2bacbf0-1aed-4c8d-816e-da0f77217f0d@arm.com>
Date: Tue, 12 Dec 2023 19:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/23] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-9-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-9-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:08, Lukasz Luba wrote:
> The new runtime table can be populated with a new power data to better
> reflect the actual efficiency of the device e.g. CPU. The power can vary
> over time e.g. due to the SoC temperature change. Higher temperature can
> increase power values. For longer running scenarios, such as game or
> camera, when also other devices are used (e.g. GPU, ISP) the CPU power can

Don't understand this sentence. So CPU power changes with higher
temperature and for longer running scenarios when other devices are
involved? Not getting the 2. part.

> change. The new EM framework is able to addresses this issue and change
> the EM data at runtime safely.

Maybe better:
The new EM framework addresses this issue by allowing to change the EM
data at runtime.

[...]

