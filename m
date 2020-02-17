Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64781160CFF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgBQIWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 03:22:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36329 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQIWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 03:22:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so8437727pfv.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 00:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7OdknIiy+mcVzd7aQyWV1gH7B9JEjMt5Lj6ZRDEpr8=;
        b=X3q7U2Wi2HB1I+pd5MyCvdx2SbSVi/MI4+Pl9GayWiDmWf6hhc/bWyRjNdBnP0RhVd
         Pvc9u0e6gtNB+WyiaCJBcYVcg7XSS30NckrboaI6NMY0D96ifyTLU9/T6v45UZGUziQu
         E37KV+LtiECp0nbfNTRbdrkvT79ba3AFqqRJXBX+/EWOWgHmHDGV96m2d+eLnhpwhg2B
         JaS3pco5z7GJBN9jMnSD8RnYKZvfQOEJnseBbCxnw9l6TPFri+RaV6svVisrIbDhnWJQ
         NXgjTnFsXpsk2190ttklnFYRgI6eIig6HWj+bo2jjkrJ4a0n8OoCWSoJD5vF0iwxtULd
         gcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7OdknIiy+mcVzd7aQyWV1gH7B9JEjMt5Lj6ZRDEpr8=;
        b=aVD4oFU9FkvoGD4FLZxcjQ6hxs0QUAwmRXVlXemYablZMfipXDNuLey32J2ble0Y8E
         zPUWDkvHUHCDn9PeadMxPEYK/9DfhjyOUPBLDV17yMUjdQp+T9sz2Qo08jsbYm0OBp0c
         b/MeXDhr+0px5FVaRFzCEe2tVD3LJ9sE3MmfhzrflSDNQYLIOwImih/LYugukeTWmEff
         5XTWi4FUrB0PtmbppyrGWD0Rgmj+6r/nwUBa8AVQAEfhriwImbdEpSxGxyoVwJk0NvQM
         Eyn0sFCQuHfvFRHNTXIgsE9eaZn6hptX8lGPrS4TKeCEySlTYK9594rQI3KmH+RkWHTx
         r7jw==
X-Gm-Message-State: APjAAAU/VoY7hrGsCK4G1oMEwj01sIol1fsdXH6fAZ1yjVokN4Z0g+AD
        FmSfSSdj2fvT073QGEmJxJ11z9XgdBw=
X-Google-Smtp-Source: APXvYqxiSnKhlHTWleNYo6G+llcadOZSJ2z30aZaAXXhDZw/HQy85HRkyUVA7+zcY5YHWWWUG/Zy0A==
X-Received: by 2002:a63:b047:: with SMTP id z7mr16691132pgo.431.1581927722973;
        Mon, 17 Feb 2020 00:22:02 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id a17sm15362314pjv.6.2020.02.17.00.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:22:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:52:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200217082200.nedwl4fa7byc54za@vireshk-i7>
References: <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213084819.jveurrsvtv72ssug@vireshk-i7>
 <VI1PR04MB4333A771266A447FB8682E2FF3150@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4333A771266A447FB8682E2FF3150@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-02-20, 10:00, Andy Tang wrote:
> From cs_dbs_update() function, I did see that sometimes the LOAD is at 100% usage.
> There is almost no application running. That must be some spikes of working running.
> Unfortunately I can't track them by cs_dbs_update() or ftrace tool.
> I doubt the ftrace can be used this way. Do you have any other suggestions? Maybe another tools?

Not sure if you used ftrace correctly, do following steps:

Enable following options in kernel config and rebuild your image.
- CONFIG_FTRACE
- CONFIG_FUNCTION_TRACER

and then run this script at runtime.


-------------------------8<-------------------------
#!/bin/bash
# Locals
BUFFER=40000
FILE="dft"

# What to trace ??
#EVENTS=" -e sched -e power -e workqueue -e irq"
EVENTS="all"

echo "Starting trace"

/usr/bin/trace-cmd start -b $BUFFER $EVENTS

#You can run some test here that you want to trace.
sleep 5

/usr/bin/trace-cmd stop

cat /sys/kernel/debug/tracing/trace > $FILE.txt
/usr/bin/trace-cmd extract -o $FILE.dat

echo "Saved trace in: "$FILE
sync
-------------------------8<-------------------------

The output file here (dft.dat) can be opened with kernel-shark tool.

Your testing platform's userspace must have trace-cmd command for this to work.

-- 
viresh
