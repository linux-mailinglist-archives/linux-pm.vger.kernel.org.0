Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C222F7D5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgG0ShP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 14:37:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:12787 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgG0ShP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 14:37:15 -0400
IronPort-SDR: oeWVKgvcTuJ614SaPR4a1SIQ1qhkR0g80lSEZUQPmUgYSc7axR+jHgjLykVS9tYFD/kCFkEzeq
 l6GDhc0N/luw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="215627810"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="215627810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 11:37:13 -0700
IronPort-SDR: 9cIKPT6VgmG6/+/GLLd6u9Etmc9ZJYpBleV4KiE7tMoqlUXeFjyTjrJs1QUIVJVSfMP7WTW3HG
 t5IKt7xYQ8ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="303560697"
Received: from nsramagi-mobl1.amr.corp.intel.com ([10.254.78.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2020 11:37:13 -0700
Message-ID: <002a22907583b2eb02fe686d0884d65a1e1e49b7.camel@linux.intel.com>
Subject: Re: [PATCH v2] pm-graph v5.7 - important s2idle fixes
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Brandt <todd.e.brandt@intel.com>
Date:   Mon, 27 Jul 2020 11:37:13 -0700
In-Reply-To: <CAJZ5v0jQ42cXamoMYVZ7uw57Sx6D1j4eORFV_ZHwy4o4g5uR_w@mail.gmail.com>
References: <415a7c7f9e9aee5fae0bbd53702e8278b19d6d9d.1595293106.git.todd.e.brandt@linux.intel.com>
         <CAJZ5v0jQ42cXamoMYVZ7uw57Sx6D1j4eORFV_ZHwy4o4g5uR_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-07-27 at 13:09 +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 21, 2020 at 3:02 AM Todd Brandt
> <todd.e.brandt@linux.intel.com> wrote:
> > 
> > Use this one instead, I've included one additional fix for
> > bootgraph.
> 
> OK
> 
> > > Raphael, this patch adds no new functionaliy, it just fixes a few
> > > key issues
> 
> It appears to be a significant update nonetheless.
> 
> > > in s2idle timeline processing. Can I get this upstream before
> > > 5.8.0 release?
> 
> And so it should go in earlier in the cycle and we are at the end of
> it, with a possible 5.8.0 release on Sunday.
I understand, I knew I was pretty late on this.
> 
> So I've applied this patch as v5.9 material, but I can add a "Cc:
> stable" tag to the commit if you want it to be backported to the
> -stable series.
> 
> Thanks!
That will be useful, thank you!

> 
> > Important fixes:
> > - in s2idle, use timekeeping_freeze trace mark instead of
> > machine_suspend
> >   to denote entry into s2idle mode.
> > - in s2idle, use machine_suspend trace mark to create a new virtual
> > device
> >   called "s2idle_enter_<n>x". It denotes an s2idle_enter call loop
> > of <n>
> >   iterations where s2idle was never actually achieved. It isn't
> > counted
> >   as "freeze time" in the header.
> > - in s2idle, only show multiple freeze times if s2idle went in and
> > out of
> >   resume_noirq. Otherwise multiple freezes are shown with "waking"
> > time
> >   subtracted (waking time is time spent outside s2idle dealing with
> > wakeups).
> > - in s2idle summaries, include "FREEZEWAKE" as an issue when at
> > least 1ms
> >   is spent waking from s2idle. A clean run should only wake for the
> > rtc timer.
> > - add support for device callbacks with matching names in the same
> > phase.
> >   In rare cases some devices register multiple callbacks from
> > separate
> >   drivers using the same name. Without this fix only one is shown.
> > - add kparamsfmt string back to fix bootgraph
> > 
> > General updates:
> > - when suspend_machine is missing, error says "failed in
> > suspend_machine"
> > - extract target count/time and add to summary title if -multi used
> > - include any instances of "timeout" in dmesg as issues to be
> > logged.
> > - fix ftrace parse to handle any number of flags (instead of just
> > 4).
> > - remove sync/async_device string from device detail, remains in
> > hover.
> > - when using callgraph (-f) add driver name to callgraph titles.
> > 
> > Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > ---
> >  tools/power/pm-graph/README        |   2 +-
> >  tools/power/pm-graph/sleepgraph.py | 249 +++++++++++++++++------
> > ------
> >  2 files changed, 149 insertions(+), 102 deletions(-)
> > 
> > diff --git a/tools/power/pm-graph/README b/tools/power/pm-
> > graph/README
> > index afe6beb40ad9..89d0a7dab4bc 100644
> > --- a/tools/power/pm-graph/README
> > +++ b/tools/power/pm-graph/README
> > @@ -6,7 +6,7 @@
> >     |_|                    |___/          |_|
> > 
> >     pm-graph: suspend/resume/boot timing analysis tools
> > -    Version: 5.6
> > +    Version: 5.7
> >       Author: Todd Brandt <todd.e.brandt@intel.com>
> >    Home Page: https://01.org/pm-graph
> > 
> > diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-
> > graph/sleepgraph.py
> > index 602e64b68ba7..46ff97e909c6 100755
> > --- a/tools/power/pm-graph/sleepgraph.py
> > +++ b/tools/power/pm-graph/sleepgraph.py
> > @@ -81,7 +81,7 @@ def ascii(text):
> >  #       store system values and test parameters
> >  class SystemValues:
> >         title = 'SleepGraph'
> > -       version = '5.6'
> > +       version = '5.7'
> >         ansi = False
> >         rs = 0
> >         display = ''
> > @@ -198,7 +198,7 @@ class SystemValues:
> >                 'suspend_console': {},
> >                 'acpi_pm_prepare': {},
> >                 'syscore_suspend': {},
> > -               'arch_thaw_secondary_cpus_end': {},
> > +               'arch_enable_nonboot_cpus_end': {},
> >                 'syscore_resume': {},
> >                 'acpi_pm_finish': {},
> >                 'resume_console': {},
> > @@ -924,10 +924,7 @@ class SystemValues:
> >                 tp = TestProps()
> >                 tf = self.openlog(self.ftracefile, 'r')
> >                 for line in tf:
> > -                       # determine the trace data type (required
> > for further parsing)
> > -                       m = re.match(tp.tracertypefmt, line)
> > -                       if(m):
> > -                               tp.setTracerType(m.group('t'))
> > +                       if tp.stampInfo(line, self):
> >                                 continue
> >                         # parse only valid lines, if this is not
> > one move on
> >                         m = re.match(tp.ftrace_line_fmt, line)
> > @@ -1244,8 +1241,8 @@ class DevProps:
> >                 if self.xtraclass:
> >                         return ' '+self.xtraclass
> >                 if self.isasync:
> > -                       return ' async_device'
> > -               return ' sync_device'
> > +                       return ' (async)'
> > +               return ' (sync)'
> > 
> >  # Class: DeviceNode
> >  # Description:
> > @@ -1301,6 +1298,7 @@ class Data:
> >                 'FAIL'    : r'(?i).*\bFAILED\b.*',
> >                 'INVALID' : r'(?i).*\bINVALID\b.*',
> >                 'CRASH'   : r'(?i).*\bCRASHED\b.*',
> > +               'TIMEOUT' : r'(?i).*\bTIMEOUT\b.*',
> >                 'IRQ'     : r'.*\bgenirq: .*',
> >                 'TASKFAIL': r'.*Freezing of tasks *.*',
> >                 'ACPI'    : r'.*\bACPI *(?P<b>[A-Za-z]*) *Error[:
> > ].*',
> > @@ -1358,11 +1356,11 @@ class Data:
> >                         if self.dmesg[p]['order'] == order:
> >                                 return p
> >                 return ''
> > -       def lastPhase(self):
> > +       def lastPhase(self, depth=1):
> >                 plist = self.sortedPhases()
> > -               if len(plist) < 1:
> > +               if len(plist) < depth:
> >                         return ''
> > -               return plist[-1]
> > +               return plist[-1*depth]
> >         def turbostatInfo(self):
> >                 tp = TestProps()
> >                 out = {'syslpi':'N/A','pkgpc10':'N/A'}
> > @@ -1382,9 +1380,12 @@ class Data:
> >                 if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
> >                         lf = sysvals.openlog(sysvals.dmesgfile,
> > 'r')
> >                 i = 0
> > +               tp = TestProps()
> >                 list = []
> >                 for line in lf:
> >                         i += 1
> > +                       if tp.stampInfo(line, sysvals):
> > +                               continue
> >                         m = re.match('[ \t]*(\[ *)(?P<ktime>[0-
> > 9\.]*)(\]) (?P<msg>.*)', line)
> >                         if not m:
> >                                 continue
> > @@ -1400,15 +1401,15 @@ class Data:
> >                                         list.append((msg, err, dir,
> > t, i, i))
> >                                         self.kerror = True
> >                                         break
> > -               msglist = []
> > +               tp.msglist = []
> >                 for msg, type, dir, t, idx1, idx2 in list:
> > -                       msglist.append(msg)
> > +                       tp.msglist.append(msg)
> >                         self.errorinfo[dir].append((type, t, idx1,
> > idx2))
> >                 if self.kerror:
> >                         sysvals.dmesglog = True
> >                 if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
> >                         lf.close()
> > -               return msglist
> > +               return tp
> >         def setStart(self, time, msg=''):
> >                 self.start = time
> >                 if msg:
> > @@ -1623,6 +1624,8 @@ class Data:
> >                                 if('src' in d):
> >                                         for e in d['src']:
> >                                                 e.time =
> > self.trimTimeVal(e.time, t0, dT, left)
> > +                                               e.end =
> > self.trimTimeVal(e.end, t0, dT, left)
> > +                                               e.length = e.end -
> > e.time
> >                 for dir in ['suspend', 'resume']:
> >                         list = []
> >                         for e in self.errorinfo[dir]:
> > @@ -1640,7 +1643,12 @@ class Data:
> >                                 if tL > 0:
> >                                         left = True if tR > tZero
> > else False
> >                                         self.trimTime(tS, tL, left)
> > -                                       self.tLow.append('%.0f'%(tL
> > *1000))
> > +                                       if 'trying' in
> > self.dmesg[lp] and self.dmesg[lp]['trying'] >= 0.001:
> > +                                               tTry =
> > round(self.dmesg[lp]['trying'] * 1000)
> > +                                               text = '%.0f (-%.0f 
> > waking)' % (tL * 1000, tTry)
> > +                                       else:
> > +                                               text = '%.0f' % (tL
> > * 1000)
> > +                                       self.tLow.append(text)
> >                         lp = phase
> >         def getMemTime(self):
> >                 if not self.hwstart or not self.hwend:
> > @@ -1776,7 +1784,7 @@ class Data:
> >                 length = -1.0
> >                 if(start >= 0 and end >= 0):
> >                         length = end - start
> > -               if pid == -2:
> > +               if pid == -2 or name not in
> > sysvals.tracefuncs.keys():
> >                         i = 2
> >                         origname = name
> >                         while(name in list):
> > @@ -1789,6 +1797,15 @@ class Data:
> >                 if color:
> >                         list[name]['color'] = color
> >                 return name
> > +       def findDevice(self, phase, name):
> > +               list = self.dmesg[phase]['list']
> > +               mydev = ''
> > +               for devname in sorted(list):
> > +                       if name == devname or
> > re.match('^%s\[(?P<num>[0-9]*)\]$' % name, devname):
> > +                               mydev = devname
> > +               if mydev:
> > +                       return list[mydev]
> > +               return False
> >         def deviceChildren(self, devname, phase):
> >                 devlist = []
> >                 list = self.dmesg[phase]['list']
> > @@ -2779,6 +2796,7 @@ class TestProps:
> >         testerrfmt = '^# enter_sleep_error (?P<e>.*)'
> >         sysinfofmt = '^# sysinfo .*'
> >         cmdlinefmt = '^# command \| (?P<cmd>.*)'
> > +       kparamsfmt = '^# kparams \| (?P<kp>.*)'
> >         devpropfmt = '# Device Properties: .*'
> >         pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9]*):
> > (?P<info>.*)'
> >         tracertypefmt = '# tracer: (?P<t>.*)'
> > @@ -2790,8 +2808,9 @@ class TestProps:
> >                 '[ +!#\*@$]*(?P<dur>[0-9\.]*) .*\|  (?P<msg>.*)'
> >         ftrace_line_fmt_nop = \
> >                 ' *(?P<proc>.*)-(?P<pid>[0-9]*) *\[(?P<cpu>[0-
> > 9]*)\] *'+\
> > -               '(?P<flags>.{4}) *(?P<time>[0-9\.]*): *'+\
> > +               '(?P<flags>\S*) *(?P<time>[0-9\.]*): *'+\
> >                 '(?P<msg>.*)'
> > +       machinesuspend = 'machine_suspend\[.*'
> >         def __init__(self):
> >                 self.stamp = ''
> >                 self.sysinfo = ''
> > @@ -2812,16 +2831,13 @@ class TestProps:
> >                         self.ftrace_line_fmt =
> > self.ftrace_line_fmt_nop
> >                 else:
> >                         doError('Invalid tracer format: [%s]' %
> > tracer)
> > -       def stampInfo(self, line):
> > +       def stampInfo(self, line, sv):
> >                 if re.match(self.stampfmt, line):
> >                         self.stamp = line
> >                         return True
> >                 elif re.match(self.sysinfofmt, line):
> >                         self.sysinfo = line
> >                         return True
> > -               elif re.match(self.cmdlinefmt, line):
> > -                       self.cmdline = line
> > -                       return True
> >                 elif re.match(self.tstatfmt, line):
> >                         self.turbostat.append(line)
> >                         return True
> > @@ -2834,6 +2850,20 @@ class TestProps:
> >                 elif re.match(self.firmwarefmt, line):
> >                         self.fwdata.append(line)
> >                         return True
> > +               elif(re.match(self.devpropfmt, line)):
> > +                       self.parseDevprops(line, sv)
> > +                       return True
> > +               elif(re.match(self.pinfofmt, line)):
> > +                       self.parsePlatformInfo(line, sv)
> > +                       return True
> > +               m = re.match(self.cmdlinefmt, line)
> > +               if m:
> > +                       self.cmdline = m.group('cmd')
> > +                       return True
> > +               m = re.match(self.tracertypefmt, line)
> > +               if(m):
> > +                       self.setTracerType(m.group('t'))
> > +                       return True
> >                 return False
> >         def parseStamp(self, data, sv):
> >                 # global test data
> > @@ -2858,9 +2888,13 @@ class TestProps:
> >                                 data.stamp[key] = val
> >                 sv.hostname = data.stamp['host']
> >                 sv.suspendmode = data.stamp['mode']
> > +               if sv.suspendmode == 'freeze':
> > +                       self.machinesuspend =
> > 'timekeeping_freeze\[.*'
> > +               else:
> > +                       self.machinesuspend = 'machine_suspend\[.*'
> >                 if sv.suspendmode == 'command' and sv.ftracefile !=
> > '':
> >                         modes = ['on', 'freeze', 'standby', 'mem',
> > 'disk']
> > -                       fp = sysvals.openlog(sv.ftracefile, 'r')
> > +                       fp = sv.openlog(sv.ftracefile, 'r')
> >                         for line in fp:
> >                                 m = re.match('.*
> > machine_suspend\[(?P<mode>.*)\]', line)
> >                                 if m and m.group('mode') in ['1',
> > '2', '3', '4']:
> > @@ -2868,9 +2902,7 @@ class TestProps:
> >                                         data.stamp['mode'] =
> > sv.suspendmode
> >                                         break
> >                         fp.close()
> > -               m = re.match(self.cmdlinefmt, self.cmdline)
> > -               if m:
> > -                       sv.cmdline = m.group('cmd')
> > +               sv.cmdline = self.cmdline
> >                 if not sv.stamp:
> >                         sv.stamp = data.stamp
> >                 # firmware data
> > @@ -3052,20 +3084,7 @@ def appendIncompleteTraceLog(testruns):
> >         for line in tf:
> >                 # remove any latent carriage returns
> >                 line = line.replace('\r\n', '')
> > -               if tp.stampInfo(line):
> > -                       continue
> > -               # determine the trace data type (required for
> > further parsing)
> > -               m = re.match(tp.tracertypefmt, line)
> > -               if(m):
> > -                       tp.setTracerType(m.group('t'))
> > -                       continue
> > -               # device properties line
> > -               if(re.match(tp.devpropfmt, line)):
> > -                       tp.parseDevprops(line, sysvals)
> > -                       continue
> > -               # platform info line
> > -               if(re.match(tp.pinfofmt, line)):
> > -                       tp.parsePlatformInfo(line, sysvals)
> > +               if tp.stampInfo(line, sysvals):
> >                         continue
> >                 # parse only valid lines, if this is not one move
> > on
> >                 m = re.match(tp.ftrace_line_fmt, line)
> > @@ -3166,33 +3185,19 @@ def parseTraceLog(live=False):
> >         if sysvals.usekprobes:
> >                 tracewatch += ['sync_filesystems',
> > 'freeze_processes', 'syscore_suspend',
> >                         'syscore_resume', 'resume_console',
> > 'thaw_processes', 'CPU_ON',
> > -                       'CPU_OFF', 'timekeeping_freeze',
> > 'acpi_suspend']
> > +                       'CPU_OFF', 'acpi_suspend']
> > 
> >         # extract the callgraph and traceevent data
> > +       s2idle_enter = hwsus = False
> >         tp = TestProps()
> > -       testruns = []
> > -       testdata = []
> > -       testrun = 0
> > -       data, limbo = 0, True
> > +       testruns, testdata = [], []
> > +       testrun, data, limbo = 0, 0, True
> >         tf = sysvals.openlog(sysvals.ftracefile, 'r')
> >         phase = 'suspend_prepare'
> >         for line in tf:
> >                 # remove any latent carriage returns
> >                 line = line.replace('\r\n', '')
> > -               if tp.stampInfo(line):
> > -                       continue
> > -               # tracer type line: determine the trace data type
> > -               m = re.match(tp.tracertypefmt, line)
> > -               if(m):
> > -                       tp.setTracerType(m.group('t'))
> > -                       continue
> > -               # device properties line
> > -               if(re.match(tp.devpropfmt, line)):
> > -                       tp.parseDevprops(line, sysvals)
> > -                       continue
> > -               # platform info line
> > -               if(re.match(tp.pinfofmt, line)):
> > -                       tp.parsePlatformInfo(line, sysvals)
> > +               if tp.stampInfo(line, sysvals):
> >                         continue
> >                 # ignore all other commented lines
> >                 if line[0] == '#':
> > @@ -3303,16 +3308,29 @@ def parseTraceLog(live=False):
> >                                         phase =
> > data.setPhase('suspend_noirq', t.time, isbegin)
> >                                         continue
> >                                 # suspend_machine/resume_machine
> > -                               elif(re.match('machine_suspend\[.*'
> > , t.name)):
> > +                               elif(re.match(tp.machinesuspend,
> > t.name)):
> > +                                       lp = data.lastPhase()
> >                                         if(isbegin):
> > -                                               lp =
> > data.lastPhase()
> > +                                               hwsus = True
> >                                                 if
> > lp.startswith('resume_machine'):
> > -                                                       data.dmesg[
> > lp]['end'] = t.time
> > +                                                       # trim out
> > s2idle loops, track time trying to freeze
> > +                                                       llp =
> > data.lastPhase(2)
> > +                                                       if
> > llp.startswith('suspend_machine'):
> > +                                                               if
> > 'trying' not in data.dmesg[llp]:
> > +                                                                  
> >      data.dmesg[llp]['trying'] = 0
> > +                                                               dat
> > a.dmesg[llp]['trying'] += \
> > +                                                                  
> >      t.time - data.dmesg[lp]['start']
> > +                                                       data.currph
> > ase = ''
> > +                                                       del
> > data.dmesg[lp]
> > +                                                       continue
> >                                                 phase =
> > data.setPhase('suspend_machine', data.dmesg[lp]['end'], True)
> >                                                 data.setPhase(phase
> > , t.time, False)
> >                                                 if data.tSuspended
> > == 0:
> >                                                         data.tSuspe
> > nded = t.time
> >                                         else:
> > +                                               if
> > lp.startswith('resume_machine'):
> > +                                                       data.dmesg[
> > lp]['end'] = t.time
> > +                                                       continue
> >                                                 phase =
> > data.setPhase('resume_machine', t.time, True)
> >                                                 if(sysvals.suspendm
> > ode in ['mem', 'disk']):
> >                                                         susp =
> > phase.replace('resume', 'suspend')
> > @@ -3343,6 +3361,19 @@ def parseTraceLog(live=False):
> >                                 # global events (outside device
> > calls) are graphed
> >                                 if(name not in testrun.ttemp):
> >                                         testrun.ttemp[name] = []
> > +                               # special handling for s2idle_enter
> > +                               if name == 'machine_suspend':
> > +                                       if hwsus:
> > +                                               s2idle_enter =
> > hwsus = False
> > +                                       elif s2idle_enter and not
> > isbegin:
> > +                                               if(len(testrun.ttem
> > p[name]) > 0):
> > +                                                       testrun.tte
> > mp[name][-1]['end'] = t.time
> > +                                                       testrun.tte
> > mp[name][-1]['loop'] += 1
> > +                                       elif not s2idle_enter and
> > isbegin:
> > +                                               s2idle_enter = True
> > +                                               testrun.ttemp[name]
> > .append({'begin': t.time,
> > +                                                       'end':
> > t.time, 'pid': pid, 'loop': 0})
> > +                                       continue
> >                                 if(isbegin):
> >                                         # create a new list entry
> >                                         testrun.ttemp[name].append(
> > \
> > @@ -3374,9 +3405,8 @@ def parseTraceLog(live=False):
> >                                 if(not m):
> >                                         continue
> >                                 n = m.group('d')
> > -                               list = data.dmesg[phase]['list']
> > -                               if(n in list):
> > -                                       dev = list[n]
> > +                               dev = data.findDevice(phase, n)
> > +                               if dev:
> >                                         dev['length'] = t.time -
> > dev['start']
> >                                         dev['end'] = t.time
> >                 # kprobe event processing
> > @@ -3479,7 +3509,12 @@ def parseTraceLog(live=False):
> >                         # add actual trace funcs
> >                         for name in sorted(test.ttemp):
> >                                 for event in test.ttemp[name]:
> > -                                       data.newActionGlobal(name,
> > event['begin'], event['end'], event['pid'])
> > +                                       if event['end'] -
> > event['begin'] <= 0:
> > +                                               continue
> > +                                       title = name
> > +                                       if name ==
> > 'machine_suspend' and 'loop' in event:
> > +                                               title =
> > 's2idle_enter_%dx' % event['loop']
> > +                                       data.newActionGlobal(title,
> > event['begin'], event['end'], event['pid'])
> >                         # add the kprobe based virtual tracefuncs
> > as actual devices
> >                         for key in sorted(tp.ktemp):
> >                                 name, pid = key
> > @@ -3548,8 +3583,9 @@ def parseTraceLog(live=False):
> >                 for p in sorted(phasedef, key=lambda
> > k:phasedef[k]['order']):
> >                         if p not in data.dmesg:
> >                                 if not terr:
> > -                                       pprint('TEST%s FAILED: %s
> > failed in %s phase' % (tn, sysvals.suspendmode, lp))
> > -                                       terr = '%s%s failed in %s
> > phase' % (sysvals.suspendmode, tn, lp)
> > +                                       ph = p if 'machine' in p
> > else lp
> > +                                       terr = '%s%s failed in %s
> > phase' % (sysvals.suspendmode, tn, ph)
> > +                                       pprint('TEST%s FAILED: %s'
> > % (tn, terr))
> >                                         error.append(terr)
> >                                         if data.tSuspended == 0:
> >                                                 data.tSuspended =
> > data.dmesg[lp]['end']
> > @@ -3611,7 +3647,7 @@ def loadKernelLog():
> >                 idx = line.find('[')
> >                 if idx > 1:
> >                         line = line[idx:]
> > -               if tp.stampInfo(line):
> > +               if tp.stampInfo(line, sysvals):
> >                         continue
> >                 m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\])
> > (?P<msg>.*)', line)
> >                 if(not m):
> > @@ -3959,18 +3995,20 @@ def addCallgraphs(sv, hf, data):
> >                 if sv.cgphase and p != sv.cgphase:
> >                         continue
> >                 list = data.dmesg[p]['list']
> > -               for devname in data.sortedDevices(p):
> > -                       if len(sv.cgfilter) > 0 and devname not in
> > sv.cgfilter:
> > +               for d in data.sortedDevices(p):
> > +                       if len(sv.cgfilter) > 0 and d not in
> > sv.cgfilter:
> >                                 continue
> > -                       dev = list[devname]
> > +                       dev = list[d]
> >                         color = 'white'
> >                         if 'color' in data.dmesg[p]:
> >                                 color = data.dmesg[p]['color']
> >                         if 'color' in dev:
> >                                 color = dev['color']
> > -                       name = devname
> > -                       if(devname in sv.devprops):
> > -                               name =
> > sv.devprops[devname].altName(devname)
> > +                       name = d if '[' not in d else
> > d.split('[')[0]
> > +                       if(d in sv.devprops):
> > +                               name = sv.devprops[d].altName(d)
> > +                       if 'drv' in dev and dev['drv']:
> > +                               name += ' {%s}' % dev['drv']
> >                         if sv.suspendmode in suspendmodename:
> >                                 name += ' '+p
> >                         if('ftrace' in dev):
> > @@ -4517,12 +4555,9 @@ def createHTML(testruns, testfail):
> >                                 # draw the devices for this phase
> >                                 phaselist = data.dmesg[b]['list']
> >                                 for d in sorted(data.tdevlist[b]):
> > -                                       name = d
> > -                                       drv = ''
> > -                                       dev = phaselist[d]
> > -                                       xtraclass = ''
> > -                                       xtrainfo = ''
> > -                                       xtrastyle = ''
> > +                                       dname = d if '[' not in d
> > else d.split('[')[0]
> > +                                       name, dev = dname,
> > phaselist[d]
> > +                                       drv = xtraclass = xtrainfo
> > = xtrastyle = ''
> >                                         if 'htmlclass' in dev:
> >                                                 xtraclass =
> > dev['htmlclass']
> >                                         if 'color' in dev:
> > @@ -4553,7 +4588,7 @@ def createHTML(testruns, testfail):
> >                                                 title += b
> >                                         devtl.html +=
> > devtl.html_device.format(dev['id'], \
> >                                                 title, left, top,
> > '%.3f'%rowheight, width, \
> > -                                               d+drv, xtraclass,
> > xtrastyle)
> > +                                               dname+drv,
> > xtraclass, xtrastyle)
> >                                         if('cpuexec' in dev):
> >                                                 for t in
> > sorted(dev['cpuexec']):
> >                                                         start, end
> > = t
> > @@ -4571,6 +4606,8 @@ def createHTML(testruns, testfail):
> >                                                 continue
> >                                         # draw any trace events for
> > this device
> >                                         for e in dev['src']:
> > +                                               if e.length == 0:
> > +                                                       continue
> >                                                 height = '%.3f' %
> > devtl.rowH
> >                                                 top = '%.3f' %
> > (rowtop + devtl.scaleH + (e.row*devtl.rowH))
> >                                                 left = '%f' %
> > (((e.time-m0)*100)/mTotal)
> > @@ -5876,7 +5913,7 @@ def getArgFloat(name, args, min, max,
> > main=True):
> > 
> >  def processData(live=False, quiet=False):
> >         if not quiet:
> > -               pprint('PROCESSING DATA')
> > +               pprint('PROCESSING: %s' % sysvals.htmlfile)
> >         sysvals.vprint('usetraceevents=%s, usetracemarkers=%s,
> > usekprobes=%s' % \
> >                 (sysvals.usetraceevents, sysvals.usetracemarkers,
> > sysvals.usekprobes))
> >         error = ''
> > @@ -5928,7 +5965,7 @@ def processData(live=False, quiet=False):
> >         sysvals.vprint('Creating the html timeline (%s)...' %
> > sysvals.htmlfile)
> >         createHTML(testruns, error)
> >         if not quiet:
> > -               pprint('DONE')
> > +               pprint('DONE:       %s' % sysvals.htmlfile)
> >         data = testruns[0]
> >         stamp = data.stamp
> >         stamp['suspend'], stamp['resume'] = data.getTimeValues()
> > @@ -5984,25 +6021,27 @@ def runTest(n=0, quiet=False):
> >         return 0
> > 
> >  def find_in_html(html, start, end, firstonly=True):
> > -       n, cnt, out = 0, len(html), []
> > -       while n < cnt:
> > -               e = cnt if (n + 10000 > cnt or n == 0) else n +
> > 10000
> > -               m = re.search(start, html[n:e])
> > -               if not m:
> > -                       break
> > -               i = m.end()
> > -               m = re.search(end, html[n+i:e])
> > +       cnt, out, list = len(html), [], []
> > +       if firstonly:
> > +               m = re.search(start, html)
> > +               if m:
> > +                       list.append(m)
> > +       else:
> > +               list = re.finditer(start, html)
> > +       for match in list:
> > +               s = match.end()
> > +               e = cnt if (len(out) < 1 or s + 10000 > cnt) else s
> > + 10000
> > +               m = re.search(end, html[s:e])
> >                 if not m:
> >                         break
> > -               j = m.start()
> > -               str = html[n+i:n+i+j]
> > +               e = s + m.start()
> > +               str = html[s:e]
> >                 if end == 'ms':
> >                         num = re.search(r'[-+]?\d*\.\d+|\d+', str)
> >                         str = num.group() if num else 'NaN'
> >                 if firstonly:
> >                         return str
> >                 out.append(str)
> > -               n += i+j
> >         if firstonly:
> >                 return ''
> >         return out
> > @@ -6034,7 +6073,7 @@ def data_from_html(file, outpath, issues,
> > fulldetail=False):
> >         else:
> >                 result = 'pass'
> >         # extract error info
> > -       ilist = []
> > +       tp, ilist = False, []
> >         extra = dict()
> >         log = find_in_html(html, '<div id="dmesglog"
> > style="display:none;">',
> >                 '</div>').strip()
> > @@ -6042,8 +6081,8 @@ def data_from_html(file, outpath, issues,
> > fulldetail=False):
> >                 d = Data(0)
> >                 d.end = 999999999
> >                 d.dmesgtext = log.split('\n')
> > -               msglist = d.extractErrorInfo()
> > -               for msg in msglist:
> > +               tp = d.extractErrorInfo()
> > +               for msg in tp.msglist:
> >                         sysvals.errorSummary(issues, msg)
> >                 if stmp[2] == 'freeze':
> >                         extra = d.turbostatInfo()
> > @@ -6059,8 +6098,8 @@ def data_from_html(file, outpath, issues,
> > fulldetail=False):
> >         if wifi:
> >                 extra['wifi'] = wifi
> >         low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
> > -       if low and '|' in low:
> > -               issue = 'FREEZEx%d' % len(low.split('|'))
> > +       if low and 'waking' in low:
> > +               issue = 'FREEZEWAKE'
> >                 match = [i for i in issues if i['match'] == issue]
> >                 if len(match) > 0:
> >                         match[0]['count'] += 1
> > @@ -6126,6 +6165,11 @@ def data_from_html(file, outpath, issues,
> > fulldetail=False):
> >                 data[key] = extra[key]
> >         if fulldetail:
> >                 data['funclist'] = find_in_html(html, '<div
> > title="', '" class="traceevent"', False)
> > +       if tp:
> > +               for arg in ['-multi ', '-info ']:
> > +                       if arg in tp.cmdline:
> > +                               data['target'] =
> > tp.cmdline[tp.cmdline.find(arg):].split()[1]
> > +                               break
> >         return data
> > 
> >  def genHtml(subdir, force=False):
> > @@ -6155,8 +6199,7 @@ def runSummary(subdir, local=True,
> > genhtml=False):
> >         pprint('Generating a summary of folder:\n   %s' % inpath)
> >         if genhtml:
> >                 genHtml(subdir)
> > -       issues = []
> > -       testruns = []
> > +       target, issues, testruns = '', [], []
> >         desc = {'host':[],'mode':[],'kernel':[]}
> >         for dirname, dirnames, filenames in os.walk(subdir):
> >                 for filename in filenames:
> > @@ -6165,6 +6208,8 @@ def runSummary(subdir, local=True,
> > genhtml=False):
> >                         data = data_from_html(os.path.join(dirname,
> > filename), outpath, issues)
> >                         if(not data):
> >                                 continue
> > +                       if 'target' in data:
> > +                               target = data['target']
> >                         testruns.append(data)
> >                         for key in desc:
> >                                 if data[key] not in desc[key]:
> > @@ -6172,6 +6217,8 @@ def runSummary(subdir, local=True,
> > genhtml=False):
> >         pprint('Summary files:')
> >         if len(desc['host']) == len(desc['mode']) ==
> > len(desc['kernel']) == 1:
> >                 title = '%s %s %s' % (desc['host'][0],
> > desc['kernel'][0], desc['mode'][0])
> > +               if target:
> > +                       title += ' %s' % target
> >         else:
> >                 title = inpath
> >         createHTMLSummarySimple(testruns, os.path.join(outpath,
> > 'summary.html'), title)
> > --
> > 2.17.1
> > 

