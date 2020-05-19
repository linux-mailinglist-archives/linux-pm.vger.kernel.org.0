Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FD1D8E58
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgESDmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 23:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 23:42:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FDBC05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:42:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so735572pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/BjPGQWQmiJ9ENgCFkWCpYAZ2ZRvlC05U7wmeNA1ao=;
        b=a8wAg21X8NCDhYNS/otY351xeR+5EHERz5A1QQV+Y7Ypl2ERVeF248y/SiArtHRjr2
         H/P89hcSwePhQAdmEt1SkBWRbl+K3UcfL+Po1sgtCSBN4y/tMU06zJb5hED6nwWPy6ux
         WWQeswadJiLmzE+BkPQJf/JTBfFDs5PcV/QGvQ1/IxFA+xa+WHfVj2cePEkKbZKqQEPu
         6nwZV97ZFVqikdwmG3HKjYDHvtGG/9qWHHovZDwyf3UTv3tRdol7DxzvcxyifdIUuCIZ
         HqBNGnb1+W3qbYdGeO1SAYUxvybcNDqTpf/PZsEoHn0nrv+UcK3g5QSBXf250lrjQ9Ee
         ACNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/BjPGQWQmiJ9ENgCFkWCpYAZ2ZRvlC05U7wmeNA1ao=;
        b=elqFXTmRvPfrfgb3bp7vsxlcqp+ZfKgPc6oO3r/AejZQp0qGW5hB/rkunxN77Hk3dk
         Yn/zFCdOe2ikn2x3gOVn/8UdmR1jNLtxgAf/fZYClYOKQr7JLjYs35i5ULQBuhFERazw
         evUYbWQ+pNJ1RBPxyG3eMooWt+yJQlQIY2wFy8dNKehaJ2XFOOa3TQ7RdmszzUmVLZnF
         dwtbE6AQjtaARu076Jvr0sQ4h2s3BZ/kktzlBQN3yowjBpUtaIEJ8wqN77kGzi3MORKH
         UA/73nuTBZ9rUQbHUXcHmaUPT8LQBBpAb4k8DxhtYGcDi3sFYfQM9cJYF/fx2LA6zkve
         x9ZA==
X-Gm-Message-State: AOAM530q2otyIfmUtVkq8OJmz+xaDaQEUSbWGLQd/fUoKnh1hQSFw9zO
        2X9h9ACw2uA9ll8Q+W6yf7xdMg==
X-Google-Smtp-Source: ABdhPJxQvr/vGk96BcQAIlKBPRTaAWbkdoqMBIawp8ZTutAuzE7F1lZMEO0quqnXBxyiSkx6DWM3mg==
X-Received: by 2002:a17:902:c254:: with SMTP id 20mr6018967plg.287.1589859738182;
        Mon, 18 May 2020 20:42:18 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id j124sm4337974pfd.116.2020.05.18.20.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:42:17 -0700 (PDT)
Date:   Tue, 19 May 2020 09:12:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200519034215.zr3gvrsokstxh2bs@vireshk-i7>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
 <20200518184010.GF2165@builder.lan>
 <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
 <20200519033703.GX2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519033703.GX2165@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-05-20, 20:37, Bjorn Andersson wrote:
> On Mon 18 May 20:31 PDT 2020, Viresh Kumar wrote:
> 
> > On 18-05-20, 11:40, Bjorn Andersson wrote:
> > > It most certainly does.
> > > 
> > > With INTERCONNECT as a bool we can handle its absence with stub
> > > functions - like every other framework does. But as a tristate then
> > > every driver with a call to the interconnect api needs an entry in
> > > Kconfig to ensure the client driver must be a module if the interconnect
> > > framework is.
> > 
> > This patch has been pushed to linux-next a few days back.
> > 
> 
> Thanks Viresh, I had missed that.

Not your fault, we didn't resend it but simply applied the old version
itself :)

-- 
viresh
