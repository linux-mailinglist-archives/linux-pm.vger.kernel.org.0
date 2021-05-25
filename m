Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D243908E4
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhEYSZL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhEYSZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 14:25:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FEDC061574;
        Tue, 25 May 2021 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e8cg3Go9ay1cnhar2MvjsyBw3YlqRz8E+iR405x9Dgc=; b=iR0QuNCD0eCZ6ocNgJeH+SVNyS
        Bp/Ri0i3JAgiNELCn1Tq6llAqYlRdajPZibujK+z3FAnMKTrFOi+9pQVqGRNQTuUQs/gOk3lX/afn
        GE7OriQo5qB2j47h9ny1Cbq11PJGhFWCISWyUHgXxhZlgDAhLbMmUPdBKPmTf/N23n7hJi4fp64Vm
        hQ+PomSxEpeW+6yPPaHZuGYc4So2U+AHzYZVdqtqpqwWK/cOuoD7gWVo5SlgoC9Qtr2e+m/xteusO
        u+h8ASL4hBkvz/maQGT4DMBO3DhxXdvJhobEQg6iBPgF01MVyXo/hfujID/JSa8kISY3MGmqBXfai
        qph2i9yA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llbiI-007FDg-Qc; Tue, 25 May 2021 18:23:34 +0000
Subject: Re: linux-next: Tree for May 25 (cpufreq/intel_pstate.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20210525163932.785c1a2a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c20c8b0-145e-bfbf-003c-28c8eeac72dc@infradead.org>
Date:   Tue, 25 May 2021 11:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525163932.785c1a2a@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/24/21 11:39 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20210524:
> 

on x86_64:
# CONFIG_ACPI is not set

../drivers/cpufreq/intel_pstate.c:495:59: warning: ‘struct cppc_perf_caps’ declared inside parameter list will not be visible outside of this definition or declaration
 static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
                                                           ^~~~~~~~~~~~~~
../drivers/cpufreq/intel_pstate.c: In function ‘intel_pstate_cppc_perf_valid’:
../drivers/cpufreq/intel_pstate.c:497:29: error: dereferencing pointer to incomplete type ‘struct cppc_perf_caps’
  return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
                             ^~
../drivers/cpufreq/intel_pstate.c: At top level:
../drivers/cpufreq/intel_pstate.c:501:13: warning: ‘struct cppc_perf_caps’ declared inside parameter list will not be visible outside of this definition or declaration
      struct cppc_perf_caps *caps)
             ^~~~~~~~~~~~~~
../drivers/cpufreq/intel_pstate.c: In function ‘intel_pstate_cppc_perf_caps’:
../drivers/cpufreq/intel_pstate.c:503:6: error: implicit declaration of function ‘cppc_get_perf_caps’; did you mean ‘get_ibs_caps’? [-Werror=implicit-function-declaration]
  if (cppc_get_perf_caps(cpu->cpu, caps))
      ^~~~~~~~~~~~~~~~~~
      get_ibs_caps
../drivers/cpufreq/intel_pstate.c:506:13: error: dereferencing pointer to incomplete type ‘struct cppc_perf_caps’
  return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
             ^~
../drivers/cpufreq/intel_pstate.c: In function ‘intel_pstate_hybrid_hwp_calibrate’:
../drivers/cpufreq/intel_pstate.c:533:24: error: storage size of ‘caps’ isn’t known
  struct cppc_perf_caps caps;
                        ^~~~
../drivers/cpufreq/intel_pstate.c:533:24: warning: unused variable ‘caps’ [-Wunused-variable]



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

