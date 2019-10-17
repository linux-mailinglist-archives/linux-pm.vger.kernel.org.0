Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237EFDB2DA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436683AbfJQQyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 12:54:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54566 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbfJQQyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 12:54:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D036F1DBBA;
        Thu, 17 Oct 2019 12:54:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=G5aHzmHaUkRm2oU/9Hp88mBL02A=; b=s8OZIK
        Kxu7zVHzA0gpPI71YqZ1Nb3102iFK6Ph0ldrvo+nlU4/S089eRHZx/C04/58hQa6
        U1z9KuO9BxQJd3ni7FrZ4xyH2ylx2M7YY/frYgWXAC+wm0WnnaJOquL2m2F3VSfE
        wio6wdmye6ZZr5/5IXgJZ4mkWee3bHarEX3ks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C77571DBB9;
        Thu, 17 Oct 2019 12:54:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=CLxvPSIC8jPU2KnOPJODvLDpaApaYkrwUGkHaLxpMzk=; b=IYGFsxPsGCoU0wTKMPo0TtpuqzTxuKOgDd+ai0KFLbx3w+zob9LJppJiifVeD9qgry4mkum6NIibk4FThNIpO9XQJgHekOAFBAaRzxlbh+/Jg56AuckgCNjTvwdEF+lhiojrYv60kKF9QrAO6pnqFHVOzA9w05Y1HEzvb/q9Vv4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C82E1DBB8;
        Thu, 17 Oct 2019 12:54:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5C2EF2DA01D7;
        Thu, 17 Oct 2019 12:54:12 -0400 (EDT)
Date:   Thu, 17 Oct 2019 12:54:12 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc
 drivers
In-Reply-To: <20191017123508.26130-1-sudeep.holla@arm.com>
Message-ID: <nycvar.YSQ.7.76.1910171251370.1546@knanqh.ubzr>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: BF4C0582-F0FE-11E9-B71D-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 17 Oct 2019, Sudeep Holla wrote:

> Hi,
> 
> Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
> there's no point in keeping it separate anymore. I wanted to post these
> patches for ages but kept postponing for no reason.

For these patches:

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
