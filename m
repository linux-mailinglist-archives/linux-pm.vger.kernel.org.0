Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A248BE927A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJ2WBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:01:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJ2WBe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:01:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so410598qtp.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IkV7pzdHzeP4W9uWbTsQ7etbx4DSYi39wSa2PvGrX6c=;
        b=RfvI6IJX3Jf/JhX4q/KwdEzN4UF0kChI0DDMFYEYqA+F9Mmy8ug1DbpQvquaIkh9+i
         DvC2bPiyTBMjQnjtE3XdjvaktrG24Ku8RyVky9le/cZDwcJXlOOxD23pjxA/jdm51GDD
         RGF1jXeDj+alZw/xoU72AmDNt2pvUZYS6T+g4AQaZxlYtmWCKbJZH6s2GHEhXX2JpiG5
         BxSR0fkB2gxylEY9WQNt4BtPh9mdmC/dIaF49bzj9Q1C3K0Wi8Kz7FyHu8dt+CPEZhvo
         tmIGP+gwiQw1CnKpEGoCrURJkOuwgXNoiEzAMHvoGPJL6TCfe0vuYxqEpgzsSceg8Nh6
         9gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IkV7pzdHzeP4W9uWbTsQ7etbx4DSYi39wSa2PvGrX6c=;
        b=mo6V5CHhXY/7RXjnJ9NFvfM/KKKZzspSDIvfR6vYnt3r3POvAGxO137lG4RohTbkm/
         8PerZIVvQB6WyrABRtg1vpl0zG5FqG1SRgUxtVug6khnUWDRC/RMB7DLXvDF7pBco/Ev
         h6j8ErODsN3SN17VdBYIzhk/jrypAx7UxIkMNvFD1vfwQSjA0NiUQWRw9JJuBzFOKO+B
         XHqoZVmbGWajdeOtAU5IT+4FrfZS2eigKS3QaznNctScux188Q9UWgPAiZBh8vaOa67M
         /g2lrcsNJpzjmX4cl1VQ/t3xUqI1H6v6Dmcwj5OFJbTS0Xx0JmDv1xQN/EfPZ977RVMh
         uC0Q==
X-Gm-Message-State: APjAAAVcRZivlOQSYeQvss9sb57h4J7cFgR/H2ryM2+lupfJ5SnkcVxx
        o+DyJTI0B5uOoZdHH3d6nJ4v6Q==
X-Google-Smtp-Source: APXvYqzRDJnyT0AvItDzx453y4BLjC9jf3D+/3b3ob/WwGM7SPp0dlo5AEIDPRWfSp/v5PbLannDWQ==
X-Received: by 2002:a0c:c3c5:: with SMTP id p5mr25907593qvi.34.1572386492432;
        Tue, 29 Oct 2019 15:01:32 -0700 (PDT)
Received: from ?IPv6:2600:1000:b063:e143:e15a:1807:6e04:c401? ([2600:1000:b063:e143:e15a:1807:6e04:c401])
        by smtp.gmail.com with ESMTPSA id u18sm89248qth.20.2019.10.29.15.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 15:01:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: "Force HWP min perf before offline" triggers unchecked MSR access errors
Date:   Tue, 29 Oct 2019 18:01:30 -0400
Message-Id: <A94C23C3-E6B9-4390-B380-C49D87731D81@lca.pw>
References: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Oct 29, 2019, at 5:47 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> The MSR_IA32_ENERGY_PERF_BIAS MSR appears to be not present, which
> should be caught by the X86_FEATURE_EPB check in
> intel_pstate_set_epb().
>=20
> Do you run this in a guest perchance?

No, it is a baremetal HPE server. The dmesg does say something like energy p=
erf bias changed from performance to normal, and the cpuflag contains epb wh=
ich I thought that would pass the feature check? I could upload the whole dm=
esg a bit later if that helps.=
