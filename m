Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12E1B5EC9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgDWPM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728988AbgDWPM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 11:12:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA9C09B040
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 08:12:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v4so7689582wme.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTeQeyto1m9v5SuM5s4edMyeNen1x/MgttTL6x5XBaI=;
        b=iw5PumrkE5tqjlzCsaMqI20CHiXkIq28cZxQKuxfCha3jMxVbtGl6SD5je3Nz0E4bV
         cqmjnLcMA2tqqU8+zI3/jNhwckZtEBWsz/83I1YLcPij7OdReAARgFEvOCsQfvSg2Hue
         CV+ej96HusLzaqZEYHGcQItEgti4huE+fBPOnCnmhtMwrLqS6xDGdq2YwK6kpsPcAgPK
         9/kZwf+6oOTKdSytvqn7NUBtlDJQzxJbbRstoM5Rn9Td82mHmVtiPUaOf9mlba3BR9X9
         WqihTMlRXZYAEeGiEiTm/kkDgR2NEXT+s/pOJLW5xVi4Jy50tC67SaICig75NffChPdy
         GP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTeQeyto1m9v5SuM5s4edMyeNen1x/MgttTL6x5XBaI=;
        b=OC0tT1Hosu8QTr0Q7gU/UrbCx64r2uYhL230LiR7h1hZj5cfwfHQJb245AR9rL3Bhw
         COu+MuxHtamUdxuNIqYX952B1mHv0/Pk2TFMRLXRRQAEn27Y2Yjwo0BBXmPLCIfotDVm
         ZdqEIPPrOQ25RnH6wZJ+w0AJ99PszjpE2OkFHb5T052fwm7BJP5wD+JPsemfExk1jkYK
         9dYHdLgxqT/wIrZ3bGcaFB3JEKN6l4siioHZZbEQmV/9iYnRYF1yvjnHwSiyUIxoKAp5
         u5C/3KAm/mOUBcs2DExf34BDJEAVoCYHM/2qHL66LsN5SAwIKJyrO46TLQ45MZMsUKyr
         UwlQ==
X-Gm-Message-State: AGi0PuZ/NeDxDmoqsis+/rxmhUU/it/8vmIDDcbrfRcgG+qSV42osqIE
        KnmvQKH4fNDqPGYqLU+G+BdkKQ==
X-Google-Smtp-Source: APiQypJEQibO8s5dDdPKk1vNMfNrO+DNEUITlcbdqfwFUErA7buEWgNGHo8cuZ6SAl0DQrcK5ToIww==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr4597986wmd.119.1587654776840;
        Thu, 23 Apr 2020 08:12:56 -0700 (PDT)
Received: from linaro.org ([37.167.216.250])
        by smtp.gmail.com with ESMTPSA id l16sm4161477wrp.91.2020.04.23.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:12:56 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:12:50 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v6 04/10] PM / EM: add support for other devices than
 CPUs in Energy Model
Message-ID: <20200423151250.GB65632@linaro.org>
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410084210.24932-5-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 09:42:04AM +0100, Lukasz Luba wrote:
> Add support for other devices that CPUs. The registration function
> does not require a valid cpumask pointer and is ready to handle new
> devices. Some of the internal structures has been reorganized in order to
> keep consistent view (like removing per_cpu pd pointers). To track usage
> of the Energy Model structures, they are protected with kref.

Why not add the energy model structure in the struct device directly?

For instance for the em_cpu_get() function, the cpu id allows to retrieve the
cpu device and then from there, the energy model instead of browsing another
list. The em_device life cycle will be tied to the struct device.

Then when the struct device and the em_device are connected, add the debugfs
with a struct device list for those which are energy aware, so you end up with
a structure:

struct em_device {
	struct device *dev;
	struct list_head em_dev_list;
};

(a global single dentry for debugfs to do a recursive delete is enough).

Locks when inspecting and add/removal called from the struct device release
function. So no need of an extra refcounting.

Does it make sense?
