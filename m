Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1C16AFE7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBXTCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 14:02:43 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44289 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgBXTCn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 14:02:43 -0500
Received: by mail-qk1-f176.google.com with SMTP id j8so9634705qka.11
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARwFyzz0JExUpMzSO2Lt2xI0FNoiJ+LE4d2sqS22dxo=;
        b=IjzPlx97zEqGWxBDi6GU/OQihwWkUpJNl3TXqHGq5V+33oDTK0QZbDMuuCsnU+g0Hm
         4ZeKrUMtPcp2n5jSF6JrQY6AZeP1YAn12xMb9E1lbjx3NP+UOw0JFOKaN1S30q3X/Pd4
         gofrWSY60fkRjxs4E2he9VK4/10PmJN1HuWNBmCP5tU8bD8ORXZO7Ufn9fjIiGVQN1Rf
         oIHGfN/bd0R+zJJTCQBxdFy6SEC6D4QuTIFT6hBEWsrthj/ZrixO803Jlt0C0CG+ABQk
         dO+HIFViGJ6o8aA8Fkvbp32HLyhiMDeavYSNBTU1azOO5Jcf1cOyQDBwrEqaziXv3uUA
         H1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARwFyzz0JExUpMzSO2Lt2xI0FNoiJ+LE4d2sqS22dxo=;
        b=HqINU/kxHNMJ7U1ZzmiyuTQBztsXdBkoDdkx3jjgs0r2jtel7nSp2ytgmE+62Foxla
         5my+/oIVxa++xct7r5APReAEccDNsZZohpKy92JaoaaXXvNPhZ7niZPtileC70fTru94
         5wGwb0No1/KP2YL0PG1GEVAXm2qhHzx9kMo3cu5uHacmqCgDBkEVoYpdXWiXn1kkKe3c
         9Y+yCQ3VsXw2wX4CpyhXacfa1qEKSfWAnwge+xAaMk8zKa7vSCgx21Vawtgif47b/TqC
         /Ka1k0oMRa1GYB5ucF/u2kmP2bEhcDmvrAF7QZLrhACc5zvyCccztLWrdwu1guAm21WZ
         s9Jg==
X-Gm-Message-State: APjAAAU2vMzPuJRJ8gyl95IMTGsO63RU3GV0vLg50ER0faf50nvHba9g
        jqqtsDkhGBdHDGh7phKlPq3oSQ==
X-Google-Smtp-Source: APXvYqxPyWWKFSBNUVffhHJrBhJGxQCVlVMLJa1LgrQfCcin8bnGiIYRzI+tEnz+HeGNTo0mqYd6EQ==
X-Received: by 2002:a37:a744:: with SMTP id q65mr9424088qke.354.1582570962035;
        Mon, 24 Feb 2020 11:02:42 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t3sm6525471qtc.8.2020.02.24.11.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:02:41 -0800 (PST)
Message-ID: <1582570959.7365.116.camel@lca.pw>
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
From:   Qian Cai <cai@lca.pw>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, elver@google.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Feb 2020 14:02:39 -0500
In-Reply-To: <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
References: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
         <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw>
         <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-02-24 at 10:54 +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 24, 2020 at 2:01 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > 
> > 
> > > On Feb 23, 2020, at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > 
> > > It may be a bug under certain conditions, but you don't mention what
> > > conditions they are.  Reporting it as a general bug is not accurate at
> > > the very least.
> > 
> > Could we rule out load tearing, store tearing and reload of global_req in cpuidle_governor_latency() for all compilers and architectures which could introduce logic bugs?
> > 
> >         int global_req = cpu_latency_qos_limit();
> > 
> >         if (device_req > global_req)
> >                 device_req = global_req;
> > 
> > If under register pressure, the compiler might get ride of the tmp variable, i.e.,
> > 
> > If (device_req > cpu_latency_qos_limit())
> > —-> race with the writer.
> >          device_req = cpu_latency_qos_limit();
> 
> Yes, there is a race here with or without the WRITE_ONCE()/READ_ONCE()
> annotations (note that these annotations don't prevent CPUs from
> reordering things, so device_req may be set before global_req
> regardless).
> 
> However, worst-case it may cause an old value to be used and that can
> happen anyway if the entire cpuidle_governor_latency_req() runs
> between the curr_value update and pm_qos_set_value() in
> pm_qos_update_target(), for example.
> 
> IOW, there is no guarantee that the new value will be used immediately
> after updating a QoS request anyway.
> 
> I agree with adding the annotations (I was considering posting a patch
> doing that myself), but just as a matter of making the intention
> clear.

OK, how about this updated texts?

[PATCH -next] power/qos: annotate a data race in pm_qos_*_value

cpu_latency_constraints.target_value could be accessed concurrently via,

cpu_latency_qos_apply
  pm_qos_update_target
    pm_qos_set_value

cpuidle_governor_latency_req
  cpu_latency_qos_limit
    pm_qos_read_value

The read is outside pm_qos_lock critical section which results in a data race.
However, the worst case is that an old value to be used and that can happen
anyway, so annotate this data race using a pair of READ|WRITE_ONCE().
