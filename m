Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F415BFC0A0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 08:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfKNHSx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 02:18:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37956 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNHSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 02:18:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3142914pgh.5
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWzq6uTLY5mVnefMYGycIvz6HVBtKdbdnPHbBMx9syQ=;
        b=ceYD8a313MDKs169JlAFjZU37hyTCz7Zt9zApCYZMO+zxys56Y5lyEEL5r2BAErgGN
         u97FAIVJdvtMF4AKb20WfzdL3fj0r2VcsYizu6+cfwhd6VtOyjH94vsfMLxoTlOZCKdO
         PDgDlTyGkSWsjrOuoHrj2eGXFI+GWgXnNRZvycu2x/WXjmUfA9RDCMcETRbgFRGkRexd
         TxHdgTPcAKn11S9XG7Wsq6BYktNmh776S6leaCc9SGT7o5MvxYRnV9tEsYnU/i8hT4zZ
         13S+Bt+RHqVzeHzcmsB/+InSLNWpGTYllv8fCtoz26xbpVh6e2FMZKkxd1nyuvl7Pt4+
         MH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWzq6uTLY5mVnefMYGycIvz6HVBtKdbdnPHbBMx9syQ=;
        b=F0lb3nVfx3z+UGRxX8oYzLWTO5fCdYNYXk+fz8tDrvLHUUngf7DaxC4ssXPR7w4oeg
         sjUl5TOau9TqxA7oYr2D0gJpc/olzlKEPk0WMhH/THSk0qi/LAt95ne6A6a18p5cxq6t
         PYDwCKVvE4oMI5+1ocQweuwV/nyjZRI6eh3Qle1P1+vVWsTgkqGzvU75CqM1AHfXv0fi
         jPsjqmYK62IBynEeWT28cW9kntspWJnkyJK5d0KUTUQ9recnX6x8EqHHOi4IV1beh2Vy
         1UsTd0HQidoMp3uun8q3DrUE/G9C90OVySBywXPt5HKYQNiQRNg0CGGstyV1qeptxH1G
         tWiQ==
X-Gm-Message-State: APjAAAXg3xWr4JZ9JxZA3IH4Fd+d+VcHcMFrjhcKx1uc1Xjsmgm0T0MT
        YxLOXnTEWlAP/H0ZQmuV3cs4yEun5ug=
X-Google-Smtp-Source: APXvYqwiE7VyDVUAUMtOVay2Oy9nvN7pjH7Mx2lfhrbs4sp6pR8AxTJgOBfH1s5ytgRPJWGmAVTf7w==
X-Received: by 2002:a17:90a:ae01:: with SMTP id t1mr10681989pjq.32.1573715932002;
        Wed, 13 Nov 2019 23:18:52 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id c3sm4711729pgi.19.2019.11.13.23.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 23:18:51 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:48:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
Message-ID: <20191114071845.ea62rlcbjiprx3t6@vireshk-i7>
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
 <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-11-19, 12:33, Amit Kucheria wrote:
> My series was going to get merged through the thermal tree. Currently
> it is hosted here[1] for linux-next testing. We could sign-off this
> patch to the thermal tree or bring the series into the PM tree. Up to
> Rafael and you.

Your thermal patches need to get based of this patch in that case.
Maybe just ask Rui to drop your last patch (for qcom-cpufreq-hw.c)
and merge things as planned. After rc1 is out, you can ask Rafael to
merge that one on top of rc1 ? Everything can still go in 5.5 that
way.

-- 
viresh
