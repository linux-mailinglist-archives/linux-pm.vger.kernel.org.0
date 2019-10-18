Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD4DBD2B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442039AbfJRFoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:44:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46929 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfJRFoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:44:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so3127053pfg.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ahk63OI60utYOmx1X43UEwxnHBgJgQRBxI72JSyLR2Y=;
        b=Yih8JGSYgB3U/98qQiRBg5zdD9tqp45DIfKnIw4wj+YWNqUEsx/KGFXvTg+Vl4DGKZ
         cSSHhesE6odKblyh1TLucrLIVRtJbb5tOy5DK5Nt+IDpje8runTFOoCipgNdB7ZmeE4D
         KWBD3wCwXfjs2T2sPT9WVho7xE0n+1Oofp1LBaWB6n27TY/DLzwzvyMRx5t1iVkmzT8T
         M38Hb3tkzKxuKkBetK5urEZcTtwTZTnENPa/C1XQZaX5ODrAgfePjocq1+g+3uRawaEu
         70t52KnSuT9XTx43xt4CowesMZxHdxMs4FrUxqI41eGdwyXLKY6wtksvSsfcFYlQzWW/
         ALQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ahk63OI60utYOmx1X43UEwxnHBgJgQRBxI72JSyLR2Y=;
        b=ogimW2iD4oNRznLnFByvD6biF9d+BBw/M+JZXOSVwitqqOrfZtauna3Fw9PtkAU1kS
         1kBYIKoKuhbbs0I1VFJsetfmWq/gJQnUptb10vCsLerPYWEKcSyYAOHB6WogmJTrgU99
         VMn8UMvXxwTZlW5VoFgh9WrU6+jtdWHUt3/qJnQlX6YoU95ebNP8jwrCTjUMv43AuOk3
         TB13XCCi/jAr5yZIWwcZtZAQBmAB6eou8TfK5a3ZsEdePJIfFfQ+2nb/HFRfKW79TP/8
         krFj/Mbc5oNX7+GPnqIK4iEtP+Eap9oIHB7Cs7EUoDvn8UGrdLaL3l02ioqwfTAv3VHb
         OcQw==
X-Gm-Message-State: APjAAAVwapJRpQLA6OfBwBrBtID9/QCSUwWCijlZEiJOOkLaLftorrdQ
        9VlmQGMiJIDOFXjH9FpGdtuAgUU16yA=
X-Google-Smtp-Source: APXvYqx+utmT/iqde3kt4kJ4rpoCw1TX48diX3ulQSDJ78ELdDEU/bI/wfkzp2s2DFsHtT8FP6pNlA==
X-Received: by 2002:a63:3853:: with SMTP id h19mr4808623pgn.55.1571377476416;
        Thu, 17 Oct 2019 22:44:36 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f185sm5546751pfb.183.2019.10.17.22.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:44:35 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:14:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191018054433.tq2euue675xk4o63@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> that the new min is less than the new max, because the QoS doesn't do
> that.]

The ->verify() callback does that for us I believe.

-- 
viresh
