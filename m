Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D2F339C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 16:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKGPmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 10:42:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfKGPmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 10:42:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id h3so3496043wrx.12
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 07:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ipnn/V5hRZ7hu1GjXibrhr7oXyNNbAnRDQ4OYlxq80Y=;
        b=okD85HFVTgikhq1O48BSsbb56HZHlyaU6g3MRgWzLdolA6A/x27sqep9fikJ53WwwO
         MG69HocsQ7BGS8SYf/crjLdsAll1PKAhGEipS+uvu8P6ucR7WlSr/ZeMUFssCjuln8SD
         MGBhP5ONnNOSsARR8R0znmqhmBQt4iKLbr1n4drxna6a8C15WIH96BL1EF+b+E9YKhzs
         QQDqnCp6Xge9qmtfLjB7JkMpBYEj1iOCiuUL71Acz3MbQzwCvaxrnkFA6CMfC4YneKuQ
         F1rtT7Prp/KyMt9EvVQuPZahHMjYycBZ7zug8LsHW4JFv3Bbcdpka9D3cFdK1DEvHcCb
         tdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ipnn/V5hRZ7hu1GjXibrhr7oXyNNbAnRDQ4OYlxq80Y=;
        b=fk2uL6PHWFVuU5l2ufdd0DE81VJedhmhdDNbWK/iUeK/dda3DwpXpYnPra0Az4qEPd
         upCpFJqr/PdQZUAOpELlQjo56qAQbWglPTA1fBPodRTYFOkLyAsJwTTGksN52aw1TIsH
         NB+UCVAHuqPR00U1uyFMn6VfVmO3cwNizZj51sF2bXIsXD3nOYX5C5/JNWMionso70Zc
         jiLUSsBcmJ1UN8XRAhlwn9ZomZ9twdd412VIBXE/ZtprPTgpMUdW7BxixUFBgBgMP3of
         AnJ6rGJjglCppUs+aLCcAw82B0Umk09Rm7GYFGF6ersGiqgwb6QvRtyHaYcVfsIomD6A
         JuQA==
X-Gm-Message-State: APjAAAWs6kJnA5dmSl9Jl4uTX/DM41cs0hvdw5O7dEgasifmsttosXI6
        nojdemHpNuSfse2UtbEMBcPHwQ==
X-Google-Smtp-Source: APXvYqxf4UNdvbjmO9uDw6PnuveAgdbD0OXqAps+kKUMW1xXeWjxa1bH04Qaph0JWzgsGM/6wBKTeg==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr3543658wru.211.1573141335566;
        Thu, 07 Nov 2019 07:42:15 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n1sm2694371wrr.24.2019.11.07.07.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:42:14 -0800 (PST)
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
Date:   Thu, 7 Nov 2019 17:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <20191107142111.GB109902@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
>> Hi Greg,
>>
>> This is a pull request with interconnect patches for the 5.5 merge window.
>> All patches have been for a while in linux-next without reported issues. The
>> details are in the signed tag. Please consider pulling into char-misc-next.
> 
> I don't know about
> 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> Shouldn't you just fix up the dependancies of subsystems that rely on
> this?  We are moving more and more to kernels that "just work" with
> everything as modules, even on arm64 systems.  So forbiding the
> interconnect code from being able to be built as a module does not feel
> good to me at all.

Thank you for commenting on this! The initial idea was to keep everything as
modular as possible. The reasons behind this change is that other core
frameworks like cpufreq (and possibly others) want to call the interconnect
APIs. Some of these frameworks are built-in only and it would be easier to
handle dependencies if interconnect core built-in too. Now each user that
can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
!INTERCONNECT.

> 
> Same for
> 0007-interconnect-Remove-unused-module-exit-code-from-cor.patch, we are
> adding module_init/exit() calls to modules, do not remove them!
> 
> 
> Can you drop those two patches and resend?  Or I can just take these out
> of the pull request and apply the rest as patches for now, if that's
> easier for you to handle.

Ok, will drop them for now and re-send!

Thanks,
Georgi
