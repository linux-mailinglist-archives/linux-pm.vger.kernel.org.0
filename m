Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAEDEA19
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfJUKyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:54:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41652 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 06:54:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so7575543pga.8
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2t4PKG/eZU3aPmwrkuhhD8Hh2tscnAFAhHGGRBX4YM=;
        b=qfF24aXttATO4K858iDxMOlawG2W88V2Efd1HhVKFd7Tq7BO/h2cM7JmXZTa5Mwa0n
         GfyvpWvUQn8jaJqHg2hK8cPDRim5U8SNXlsjoSYVCtedIJMyrVyTmGNQ0sF8JqGcfXhY
         9u2btxLWxsUmAVw6n8IDr6kds1pz3kXtxNMITR3vegl3bNMahBUcZzG3LfY4wKJ2124X
         6QJ5n3buU28VZAiUjoyec1z37S4prkbnEpWx5UQm5GS0KfWbdVPaouRS92IGfOU4VNJl
         NJ1IXxGMZo7fBioOuzrNEe4FnMeYHuB88Jb8a6Kwphhz6o+p5N8Bm2GRX+CUlu7DuCf1
         wQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2t4PKG/eZU3aPmwrkuhhD8Hh2tscnAFAhHGGRBX4YM=;
        b=HfJfbQq48K+CDTx6avPGz9/V7+7Xs3jjOMUdfEi9zpQ4bZwbPLQ5V4FbD143Yhkl4o
         aWjU2OscqQEKeZZEpAqEIh/gid/WvFGP1Zh672YPVMg5OeNhvDAJ7ZHfhAf5REpZyx30
         q0DhFKQUZtNVMuLUgFZKGoxP7PtpSKPT/MQJfHpXI/mUpA0GOB+oMWPw+tLt2QEtPk2b
         yAVhHt+QmdCIWDw6eo6sf/biyn2Q1KaFyHC1X+VPB4+9Zl7rhYXwROWC2t6z2B064iwC
         HqrcZ1BRzouLk9nQMr6Z8+4EEAVMqZAwsoAz87zfjo4qLXOEIP3w80qVa6HfqKZiuqxt
         7Pjw==
X-Gm-Message-State: APjAAAXGzTldfU0stKT+r9vsWtyFqSG5dK/VLVi1k/C+nOaKSyiTRRPq
        Uw93qGzjXBtKtVW5U1HiLkw4sQ==
X-Google-Smtp-Source: APXvYqzc+VIvFaAIr1m5192kISlYR+tFNl07KgG0K9Am2YZM+hvPaKnDaJ6T+4BBNOPsidRHUzrl9w==
X-Received: by 2002:a63:3044:: with SMTP id w65mr24426425pgw.384.1571655264745;
        Mon, 21 Oct 2019 03:54:24 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id o60sm15848553pje.21.2019.10.21.03.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 03:54:23 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:24:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v3 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc
 drivers
Message-ID: <20191021105419.ud7he23j2icrwo4w@vireshk-i7>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018103749.11226-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 11:37, Sudeep Holla wrote:
> Hi,
> 
> Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
> there's no point in keeping it separate anymore. I wanted to post these
> patches for ages but kept postponing for no reason.
> 
> Regards,
> Sudeep
> 
> v1->v2:
> 	- generated the patch using -B that helps to keep delta short
> 	  for review
> 	- Split the last patch into 3 different patches to deal with
> 	  removing bL_ops, debug messages and other code formatting
> 	  separately
> 
> v2->v3:
> 	- Added Nico's ack
> 	- Added back blank lines and extra braces as suggested by Viresh
> 	- Updated copyright year correctly

Applied. Thanks.

-- 
viresh
